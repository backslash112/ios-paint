#import <Foundation/Foundation.h>
#import "Stroke.h"


@interface Painting : NSObject

- (void)addStroke:(Stroke *)stroke;

@end


@interface Painting(collections)

@property (readonly, nonatomic) NSArray *strokes;

@end
