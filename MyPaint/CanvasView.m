#import "CanvasView.h"


@implementation CanvasView

- (void)dealloc
{
  self.strokes = nil;
}

#pragma mark - Drawing routines

- (void)drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  for (Stroke *stroke in self.strokes) {
    [self drawWithContext:context stroke:stroke];
  }
}

- (void)drawWithContext:(CGContextRef)context stroke:(Stroke *)stroke
{
  [self prepareContext:context forDrawingStroke:stroke];
  [self drawWithContext:context lineWithPoints:stroke.points];
}

- (void)prepareContext:(CGContextRef)context forDrawingStroke:(Stroke *)stroke
{
  CGContextSetStrokeColorWithColor(context, [stroke.color CGColor]);
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context, stroke.width);
  CGContextMoveToPoint(context, 0, 0);
}

- (void)drawWithContext:(CGContextRef)context lineWithPoints:(NSArray *)points
{
  if ([points count] > 0) {
    CGPoint point = [points[0] CGPointValue];
    CGContextMoveToPoint(context, point.x, point.y);
  }

  for (NSValue *value in points) {
    CGPoint point = [value CGPointValue];
    CGContextAddLineToPoint(context, point.x, point.y);
  }

  CGContextStrokePath(context);
}

@end
