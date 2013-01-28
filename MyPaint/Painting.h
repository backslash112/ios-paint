#import <Foundation/Foundation.h>
#import "Stroke.h"


@protocol PaintingDelegate;


// Painting is a document, containing strokes.
//
@interface Painting : UIDocument

@property (assign, readonly, nonatomic) NSInteger numberOfStrokes;
@property (weak, nonatomic) id <PaintingDelegate> delegate;

- (void)addStroke:(Stroke *)stroke;
- (void)removeLastStroke;

- (Stroke *)strokeAtIndex:(NSInteger)index;
- (Stroke *)lastStroke;

@end


@protocol PaintingDelegate <NSObject>

@optional
- (void)strokeDidInsertAtIndex:(NSInteger)index;
- (void)strokeDidRemoveAtIndex:(NSInteger)index;

@end
