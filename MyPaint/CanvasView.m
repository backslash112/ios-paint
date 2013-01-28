#import "CanvasView.h"
#import "PaintingRenderer.h"


@implementation CanvasView {
  UIImage *_prerenderedShapesImage;
  NSInteger _numberOfPrerenderedShapes;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

#pragma mark - Public interface

- (void)reloadData
{
  [self setNeedsDisplay];
}

- (void)didInsertShapeAtIndex:(NSInteger)index
{
  NSInteger indexOfLastPrerenderedShape = _numberOfPrerenderedShapes - 1;
  BOOL shouldPrerenderFromScratch = index <= indexOfLastPrerenderedShape;

  if (shouldPrerenderFromScratch) {
    [self dropPrerenderedShapesImage];
  }

  [self setNeedsDisplay];
}

- (void)didChangeShapeAtIndex:(NSInteger)index
{
  // Essentialy the same
  [self didInsertShapeAtIndex:index];
}

- (void)didRemoveShapeAtIndex:(NSInteger)index
{
  // Essentialy the same
  [self didInsertShapeAtIndex:index];
}

#pragma mark - Drawing routines

- (void)drawRect:(CGRect)rect
{
  if (self.datasource) {
    [self prerenderIfNeeded];
    [self drawPrerenderedShapesImage];
    [self drawShapes];
  }
}

- (BOOL)shouldPrerender
{
  return [self numberOfShapesToPrerender] > 0;
}

- (NSInteger)numberOfShapesToPrerender
{
  NSInteger numberOfShapes = [self.datasource numberOfShapesInCanvasView:self];
  NSInteger numberOfShapesThatCouldChangeShortly = 1;
  return numberOfShapes - _numberOfPrerenderedShapes - numberOfShapesThatCouldChangeShortly;
}

- (void)prerenderIfNeeded
{
  if ([self shouldPrerender]) {
    [self prerender];
  }
}

- (void)prerender
{
  NSInteger indexOfFirstShapeToPrerender = _numberOfPrerenderedShapes;
  NSInteger indexOfLastShapeToPrerender = indexOfFirstShapeToPrerender + [self numberOfShapesToPrerender] - 1;

  UIGraphicsBeginImageContext(self.frame.size);

  [self fixContextOrientation];

  [self drawPrerenderedShapesImage];
  
  for (int i = indexOfFirstShapeToPrerender; i <= indexOfLastShapeToPrerender; i++) {
    Shape *shape = [self.datasource canvasView:self shapeAtIndex:i];
    [shape drawWithCurrentContext];
  }

  _prerenderedShapesImage = UIGraphicsGetImageFromCurrentImageContext();

  UIGraphicsEndImageContext();

  _numberOfPrerenderedShapes = indexOfLastShapeToPrerender + 1;
}

- (void)drawPrerenderedShapesImage
{
  if (_prerenderedShapesImage != nil) {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGRect imageRect = {
      .origin = CGPointMake(0.0f, 0.0f),
      .size = [_prerenderedShapesImage size]
    };

    CGContextDrawImage(context, imageRect, [_prerenderedShapesImage CGImage]);
  }
}

- (void)fixContextOrientation
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextTranslateCTM(context, 0, self.frame.size.height);
  CGContextScaleCTM(context, 1.0, -1.0);
}

- (void)drawShapes
{
  NSInteger indexOfFirstShapeToDraw = _numberOfPrerenderedShapes;
  NSInteger numberOfShapes = [self.datasource numberOfShapesInCanvasView:self];

  for (int i = indexOfFirstShapeToDraw; i < numberOfShapes; i++) {
    Shape *shape = [self.datasource canvasView:self shapeAtIndex:i];
    [shape drawWithCurrentContext];
  }
}

- (void)dropPrerenderedShapesImage
{
  _prerenderedShapesImage = nil;
  _numberOfPrerenderedShapes = 0;
}

@end
