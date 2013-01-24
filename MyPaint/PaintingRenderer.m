#import "PaintingRenderer.h"


@implementation PaintingRenderer

+ (void)drawPainting:(Painting *)painting count:(NSInteger)count
{
  [self drawPrerenderedImage:painting.prerenderedImage];
  
  if ([painting.strokes count] > 0) {
    NSInteger lastStrokeToDrawIndex = MIN([painting.strokes count], count);

    for (int i = 0; i < lastStrokeToDrawIndex; i++) {
      [self drawStroke:painting.strokes[i]];
    }
  }
}

+ (void)drawPainting:(Painting *)painting
{
  if ([painting.strokes count] > 0) {
    [self drawPainting:painting count:[painting.strokes count]];
  }
}

+ (void)drawStroke:(Stroke *)stroke
{
  [self prepareContextForDrawingStroke:stroke];
  [self drawLineWithPoints:stroke.points];
}

+ (void)prepareContextForDrawingStroke:(Stroke *)stroke
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetStrokeColorWithColor(context, [stroke.color CGColor]);
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context, stroke.width);
  CGContextMoveToPoint(context, 0, 0);
}

+ (void)drawLineWithPoints:(NSArray *)points
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

+ (void)drawPrerenderedImage:(UIImage *)image
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGRect imageRect = {
    .origin = CGPointMake(0.0f, 0.0f),
    .size = [image size]
  };

  CGContextDrawImage(context, imageRect, [image CGImage]);
}

@end
