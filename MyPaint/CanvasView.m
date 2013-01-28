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

- (void)reloadData
{

}

- (void)insertShape:(Shape *)shape atIndex:(NSInteger)index
{
  
}

#pragma mark - Drawing routines

- (void)drawRect:(CGRect)rect
{
  if (self.datasource != nil) {
    NSInteger numberOfShapes = [self.datasource numberOfShapesInCanvasView:self];

    for (NSInteger i = 0; i < numberOfShapes; i++) {
      Shape *shape = [self.datasource canvasView:self shapeAtIndex:i];
      [shape drawWithCurrentContext];
    }
  }
}

@end
