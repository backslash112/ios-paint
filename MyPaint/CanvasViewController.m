#import "CanvasViewController.h"


@interface CanvasViewController ()

@property (strong, nonatomic) NSMutableArray *strokes;
@property (strong, nonatomic) Stroke *activeStroke;

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
  self.activeStroke = [[Stroke alloc] init];
  self.activeStroke.color = [UIColor blueColor];
  self.activeStroke.width = 10;

  CGPoint newPoint = [[touches anyObject] locationInView:self.view];
  [self.activeStroke.points addObject:[NSValue valueWithCGPoint:newPoint]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint newPoint = [[touches anyObject] locationInView:self.view];
  [self.activeStroke.points addObject:[NSValue valueWithCGPoint:newPoint]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self.strokes addObject:self.activeStroke];
  [self.view setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

}

#pragma mark - Properties

- (void)setStrokes:(NSMutableArray *)strokes
{
  _strokes = strokes;
  self.view.strokes = _strokes;
}

@end
