#import "Shape.h"


@protocol CanvasViewDatasource;


@interface CanvasView : UIView

@property (weak, nonatomic) id <CanvasViewDatasource> datasource;

// Drop prerendered shapes and draw from scratch.
- (void)reloadData;

// Use following notifiers instead of |reloadData|
// to preserve prerendered shapes when possible.
- (void)didInsertShapeAtIndex:(NSInteger)index;
- (void)didChangeShapeAtIndex:(NSInteger)index;
- (void)didRemoveShapeAtIndex:(NSInteger)index;

@end


@protocol CanvasViewDatasource

- (NSInteger)numberOfShapesInCanvasView:(CanvasView *)canvasView;
- (Shape *)canvasView:(CanvasView *)canvasView shapeAtIndex:(NSInteger)index;

@end
