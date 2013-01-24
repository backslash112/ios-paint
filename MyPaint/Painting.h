#import <Foundation/Foundation.h>
#import "Stroke.h"


@interface Painting : NSObject

@property (strong, nonatomic) UIImage *prerenderedImage;


- (void)addStroke:(Stroke *)stroke;
- (void)removeFirstStrokesCount:(NSInteger)count;

@end


@interface Painting(collections)

@property (readonly, nonatomic) NSArray *strokes;

@end
