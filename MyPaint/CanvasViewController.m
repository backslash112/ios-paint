#import "CanvasViewController.h"
#import "Stroke.h"
#import "StrokeShape.h"


@implementation CanvasViewController

@dynamic view;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.strokeColor = [UIColor blackColor];
    self.strokeWidth = 10.0f;
    
    //self.painting = [[Painting alloc] init];
  }
  return self;
}

- (void)loadView
{
  self.view = [[CanvasView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  self.view.datasource = self;
}

#pragma mark - Properties

- (void)setPainting:(Painting *)painting
{
  _painting.delegate = nil;
  painting.delegate = self;

  _painting = painting;
}

- (Stroke *)activeStroke
{
  return [self.painting lastStroke];
}

- (void)setActiveStroke:(Stroke *)stroke
{
  [self.painting addStroke:stroke];
}

#pragma mark - CanvasViewDatasource

- (NSInteger)numberOfShapesInCanvasView:(CanvasView *)canvasView
{
  return self.painting.numberOfStrokes;
}

- (Shape *)canvasView:(CanvasView *)canvasView shapeAtIndex:(NSInteger)index
{
  Stroke *stroke = [self.painting strokeAtIndex:index];
  return [[StrokeShape alloc] initWithStroke:stroke];
}

#pragma mark - PaintingDelegate

- (void)strokeDidInsertAtIndex:(NSInteger)index
{
  [self.view didInsertShapeAtIndex:index];
}

- (void)strokeDidRemoveAtIndex:(NSInteger)index
{
  [self.view didRemoveShapeAtIndex:index];
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

  [self setActiveStroke:newStroke];
}

- (void)continueStrokeWithNextPoint:(CGPoint)nextPoint
{
  [self.activeStroke.points addObject:[NSValue valueWithCGPoint:nextPoint]];
  [self.view didChangeShapeAtIndex:self.painting.numberOfStrokes - 1];
}

- (void)endStrokeWithPoint:(CGPoint)endPoint
{
  [self.activeStroke.points addObject:[NSValue valueWithCGPoint:endPoint]];
  [self.view didChangeShapeAtIndex:self.painting.numberOfStrokes - 1];
}

@end




































