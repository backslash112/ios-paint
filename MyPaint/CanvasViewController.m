#import "CanvasViewController.h"


@interface CanvasViewController ()

@property (strong, nonatomic) NSMutableArray *strokes;
@property (readonly, nonatomic) Stroke *activeStroke;

@end


@implementation CanvasViewController

@dynamic view;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.strokeColor = [UIColor blackColor];
    self.strokeWidth = 10.0f;
    
    self.strokes = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)loadView
{
  self.view = [[CanvasView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
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
  // Essentially the same
  [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  // Essentially the same
  [self touchesMoved:touches withEvent:event];
}

#pragma mark - Properties

- (void)setStrokes:(NSMutableArray *)strokes
{
  _strokes = strokes;
  self.view.strokes = _strokes;
}

- (Stroke *)activeStroke
{
  return [self.strokes lastObject];
}

#pragma mark - Stroke creation

- (void)createStrokeWithStartPoint:(CGPoint)startPoint
{
  Stroke *newStroke = [[Stroke alloc] init];

  [self.strokes addObject:newStroke];

  self.activeStroke.color = self.strokeColor;
  self.activeStroke.width = self.strokeWidth;

  [self.activeStroke.points addObject:[NSValue valueWithCGPoint:startPoint]];
}

- (void)continueStrokeWithNextPoint:(CGPoint)nextPoint
{
  [self.activeStroke.points addObject:[NSValue valueWithCGPoint:nextPoint]];
  [self.view setNeedsDisplay];
}

@end
