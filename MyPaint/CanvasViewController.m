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
  Stroke *newStroke = [[Stroke alloc] init];
  
  [self.strokes addObject:newStroke];
  
  self.activeStroke.color = [UIColor blueColor];
  self.activeStroke.width = 10;

  CGPoint newPoint = [[touches anyObject] locationInView:self.view];
  [self.activeStroke.points addObject:[NSValue valueWithCGPoint:newPoint]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint newPoint = [[touches anyObject] locationInView:self.view];
  [self.activeStroke.points addObject:[NSValue valueWithCGPoint:newPoint]];
  [self.view setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self.view setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self.view setNeedsDisplay];
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

@end
