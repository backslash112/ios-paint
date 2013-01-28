#import <Foundation/Foundation.h>
#import "Stroke.h"


// Painting is a document, containing strokes.
//
@interface Painting : NSObject

@property (assign, readonly, nonatomic) NSInteger numberOfStrokes;

- (void)addStroke:(Stroke *)stroke;
- (void)insertStroke:(Stroke *)stroke atIndex:(NSInteger)index;

- (void)removeStrokeAtIndex:(NSInteger)index;

- (Stroke *)strokeAtIndex:(NSInteger)index;
- (Stroke *)lastStroke;

@end
