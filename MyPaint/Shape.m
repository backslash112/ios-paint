#import "Shape.h"


@implementation Shape

- (void)drawWithContext:(CGContextRef)context
{
  // To be implemented in subclasses.
}

- (void)drawWithCurrentContext
{
  [self drawWithContext:UIGraphicsGetCurrentContext()];
}

@end
