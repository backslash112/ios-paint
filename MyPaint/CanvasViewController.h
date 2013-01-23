#import <UIKit/UIKit.h>
#import "CanvasView.h"


@interface CanvasViewController : UIViewController

@property (strong, nonatomic) NSArray *strokes;
@property (readonly, nonatomic) CanvasView *canvasView;

@end
