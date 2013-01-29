#import "CanvasView.h"


#define PRERENDERING_ENABLED 1


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
  [self dropPrerenderedShapesImage];
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
#if PRERENDERING_ENABLED
    [self prerenderIfNeeded];
    [self drawPrerenderedShapesImage];
#endif
    [self drawShapes];
  }
}

- (BOOL)shouldPrerender
{
  return [self numberOfShapesToPrerender] > 0;
}

- (NSInteger)numberOfShapesToPrerender
{
  NSInteger numberOfShapesThatCouldChangeShortly = 1;
  return [self numberOfShapes] - _numberOfPrerenderedShapes - numberOfShapesThatCouldChangeShortly;
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

  UIGraphicsBeginImageContext(CGSizeMake(768.0f, 1024.0f));
  
  [self flipContextUpsideDown];

  [self drawPrerenderedShapesImage];
  
  for (int i = indexOfFirstShapeToPrerender; i <= indexOfLastShapeToPrerender; i++) {
    [[self shapeAtIndex:i] drawWithCurrentContext];
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

- (void)flipContextUpsideDown
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextTranslateCTM(context, 0, 1024.0f);
  CGContextScaleCTM(context, 1.0, -1.0);
}

- (void)dropPrerenderedShapesImage
{
  _prerenderedShapesImage = nil;
  _numberOfPrerenderedShapes = 0;
}

- (void)drawShapes
{
  NSInteger indexOfFirstShapeToDraw = _numberOfPrerenderedShapes;
  NSInteger numberOfShapes = [self numberOfShapes];

  for (int i = indexOfFirstShapeToDraw; i < numberOfShapes; i++) {
    [[self shapeAtIndex:i] drawWithCurrentContext];
  }
}

#pragma mark - Helpers

- (NSInteger)numberOfShapes
{
  return [self.datasource numberOfShapesInCanvasView:self];
}

- (Shape *)shapeAtIndex:(NSInteger)index
{
  return [self.datasource canvasView:self shapeAtIndex:index];
}

@end
