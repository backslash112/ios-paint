#import <Foundation/Foundation.h>
#import "Painting.h"


@interface PaintingRenderer : NSObject

+ (void)drawPainting:(Painting *)painting count:(NSInteger)count;

+ (void)drawPainting:(Painting *)painting;

+ (void)drawStroke:(Stroke *)stroke;

@end
