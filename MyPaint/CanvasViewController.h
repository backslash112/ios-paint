#import <UIKit/UIKit.h>
#import "CanvasView.h"
#import "Painting.h"


@interface CanvasViewController : UIViewController <CanvasViewDatasource, PaintingDelegate>

@property (strong, nonatomic) CanvasView *view;

@property (strong, nonatomic) UIColor *strokeColor;
@property (assign, nonatomic) CGFloat strokeWidth;
@property (strong, nonatomic) Painting *painting;

@end
