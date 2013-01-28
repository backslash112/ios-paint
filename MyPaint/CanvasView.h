#import <UIKit/UIKit.h>
#import "Stroke.h"
#import "Painting.h"
#import "Shape.h"


@protocol CanvasViewDatasource;


@interface CanvasView : UIView

@property (weak, nonatomic) id <CanvasViewDatasource> datasource;

- (void)reloadData;
- (void)insertShape:(Shape *)shape atIndex:(NSInteger)index;

@end


@protocol CanvasViewDatasource

- (NSInteger)numberOfShapesInCanvasView:(CanvasView *)canvasView;
- (Shape *)canvasView:(CanvasView *)canvasView shapeAtIndex:(NSInteger)index;

@end
