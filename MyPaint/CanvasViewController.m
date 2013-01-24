#import "CanvasViewController.h"
#import "Stroke.h"
#import "PaintingRenderer.h"


@interface CanvasViewController ()

@property (assign, nonatomic) NSInteger prerenderedStrokesCount;

@end


@implementation CanvasViewController

@dynamic view;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.strokeColor = [UIColor blackColor];
    self.strokeWidth = 10.0f;
    
    self.painting = [[Painting alloc] init];
    self.prerenderedStrokesCount = 0;
  }
  return self;
}

- (void)loadView
{
  self.view = [[CanvasView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}

#pragma mark - Properties

- (void)setPainting:(Painting *)painting
{
  _painting = painting;
  self.view.painting = painting;
}

#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
  [self createStrokeWithStartPoint:touchPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
  [self continueStrokeWithNextPoint:touchPoint];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
  [self endStrokeWithPoint:touchPoint];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  // Essentially the same
  [self touchesEnded:touches withEvent:event];
}

#pragma mark - Stroke creation

- (void)createStrokeWithStartPoint:(CGPoint)startPoint
{
  Stroke *newStroke = [[Stroke alloc] init];

  newStroke.color = self.strokeColor;
  newStroke.width = self.strokeWidth;
  [newStroke.points addObject:[NSValue valueWithCGPoint:startPoint]];

  self.view.activeStroke = newStroke;
}

- (void)continueStrokeWithNextPoint:(CGPoint)nextPoint
{
  if ([self shouldSplitActiveStroke]) {
    [self splitActiveStrokeOnPoint:nextPoint];
  } else {
    [self.view.activeStroke.points addObject:[NSValue valueWithCGPoint:nextPoint]];
  }
  
  [self.view setNeedsDisplay];
}

- (void)endStrokeWithPoint:(CGPoint)endPoint
{
  [self.view.activeStroke.points addObject:[NSValue valueWithCGPoint:endPoint]];
  [self moveActiveStrokeToPainting];

  if ([self shouldPrerender]) {
    [self prerender];
  }
}

- (void)moveActiveStrokeToPainting
{
  if (self.view.activeStroke) {
    [self.painting addStroke:self.view.activeStroke];
    self.view.activeStroke = nil;
  }
}

- (BOOL)shouldSplitActiveStroke
{
  return [self.view.activeStroke.points count] >= [self minPointsInStrokeCountToSplit];
}

- (void)splitActiveStrokeOnPoint:(CGPoint)point
{
  [self endStrokeWithPoint:point];
  [self createStrokeWithStartPoint:point];
}

#pragma mark - Painting prerendering

- (NSInteger)undoableStrokesCount
{
  return 0; // Undo is disabled for now
}

- (NSInteger)minStrokesCountToPrerenderInOnePass
{
  return 10;
}

- (NSInteger)minPointsInStrokeCountToSplit
{
  return 10;
}

- (BOOL)shouldPrerender
{
  NSInteger strokesThatShouldBePrerenderedButCurrentlyNotCount =
      [self.painting.strokes count] - self.prerenderedStrokesCount - [self undoableStrokesCount];
  return strokesThatShouldBePrerenderedButCurrentlyNotCount >= [self minStrokesCountToPrerenderInOnePass];
}

- (void)prerender
{
  UIGraphicsBeginImageContext(self.view.frame.size);

  [self fixContextOrientation];

  NSInteger strokesToPrerenderCount = [self.painting.strokes count] - [self undoableStrokesCount];
  
  [PaintingRenderer drawPainting:self.painting count:strokesToPrerenderCount];

  UIImage *prerenderedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  self.painting.prerenderedImage = prerenderedImage;
  [self.painting removeFirstStrokesCount:strokesToPrerenderCount];
  self.prerenderedStrokesCount = strokesToPrerenderCount;
}

- (void)fixContextOrientation
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextTranslateCTM(context, 0, self.view.frame.size.height);
  CGContextScaleCTM(context, 1.0, -1.0);
}

@end




































