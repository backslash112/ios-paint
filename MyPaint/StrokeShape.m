#import "StrokeShape.h"


@implementation StrokeShape {
  Stroke *_stroke;
}

- (id)initWithStroke:(Stroke *)stroke
{
  NSParameterAssert(stroke != nil);
  
  if (self = [super init]) {
    _stroke = stroke;
  }

  return self;
}

- (id)init
{
  @throw [NSException exceptionWithName:@"Method is not allowed"
                                 reason:@"Call initWithStroke: instead"
                               userInfo:nil];
}

- (void)drawWithContext:(CGContextRef)context
{
  [self prepareContext:context];
  [self drawStrokeWithContext:context];
}

- (void)prepareContext:(CGContextRef)context
{
  CGContextSetStrokeColorWithColor(context, [_stroke.color CGColor]);
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context, _stroke.width);
  CGContextMoveToPoint(context, 0, 0);
}

- (void)drawStrokeWithContext:(CGContextRef)context
{
  if ([_stroke.points count] > 0) {
    CGPoint point = [_stroke.points[0] CGPointValue];
    CGContextMoveToPoint(context, point.x, point.y);
  }

  for (NSValue *value in _stroke.points) {
    CGPoint point = [value CGPointValue];
    CGContextAddLineToPoint(context, point.x, point.y);
  }

  CGContextStrokePath(context);
}

@end
