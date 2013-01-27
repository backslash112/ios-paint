#import "CanvasView.h"
#import "PaintingRenderer.h"


@implementation CanvasView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

#pragma mark - Drawing routines

- (void)drawRect:(CGRect)rect
{
  [self drawPainting];
  [self drawActiveStroke];
}

- (void)drawPainting
{
  [PaintingRenderer drawPainting:self.painting];
}

- (void)drawActiveStroke
{
  if (self.activeStroke) {
    [PaintingRenderer drawStroke:self.activeStroke];
  }
}

@end
