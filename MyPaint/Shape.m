#import "Shape.h"


@implementation Shape

- (void)drawWithContext:(CGContextRef)context
{
  // To be implemented in subclasses.
  @throw [NSException exceptionWithName:@"Method is not implemented"
                                 reason:@"drawWithContext: is not implemented in the Shape class"
                               userInfo:nil];
}

- (void)drawWithCurrentContext
{
  [self drawWithContext:UIGraphicsGetCurrentContext()];
}

@end
