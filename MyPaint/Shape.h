#import <Foundation/Foundation.h>


// Shape is an abstract entity that could be drawn on a canvas.
// Subclasses should implement |drawWithContext:| method.
//
@interface Shape : NSObject

- (void)drawWithContext:(CGContextRef)context;
- (void)drawWithCurrentContext;

@end
