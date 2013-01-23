#import "CanvasView.h"


@implementation CanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context, 15);

  CGContextMoveToPoint(context, 0, 0);
  CGContextAddLineToPoint(context, 10, 10);
  CGContextAddLineToPoint(context, 100, 100);
  CGContextStrokePath(context);
}

@end
