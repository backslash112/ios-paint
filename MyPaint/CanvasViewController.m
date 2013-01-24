#import "CanvasViewController.h"
#import "Painting.h"
#import "Stroke.h"


@interface CanvasViewController ()

@property (strong, nonatomic) Painting *painting;

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
  [self continueStrokeWithNextPoint:touchPoint];
  [self moveActiveStrokeToPainting];
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
  [self.view.activeStroke.points addObject:[NSValue valueWithCGPoint:nextPoint]];
  [self.view setNeedsDisplay];
}

- (void)moveActiveStrokeToPainting
{
  if (self.view.activeStroke) {
    [self.painting addStroke:self.view.activeStroke];
    self.view.activeStroke = nil;
  }
}

@end
