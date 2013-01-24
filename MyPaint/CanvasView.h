#import <UIKit/UIKit.h>
#import "Stroke.h"
#import "Painting.h"


@interface CanvasView : UIView

@property (weak, nonatomic) Painting *painting;
@property (strong, nonatomic) Stroke *activeStroke;

@end
