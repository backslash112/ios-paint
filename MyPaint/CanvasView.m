#import "CanvasView.h"


@implementation CanvasView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

#pragma mark - Drawing routines

- (void)drawRect:(CGRect)rect
{
  for (Stroke *stroke in self.painting.strokes) {
    [self drawStroke:stroke];
  }

  [self drawStroke:self.activeStroke];
}

- (void)drawStroke:(Stroke *)stroke
{
  [self prepareContextForDrawingStroke:stroke];
  [self drawWithContextLineWithPoints:stroke.points];
}

- (void)prepareContextForDrawingStroke:(Stroke *)stroke
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetStrokeColorWithColor(context, [stroke.color CGColor]);
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context, stroke.width);
  CGContextMoveToPoint(context, 0, 0);
}

- (void)drawWithContextLineWithPoints:(NSArray *)points
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  
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
