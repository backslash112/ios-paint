#import "ColorPicker.h"


@interface ColorPicker() {
  CGContextRef _colorWheelBitmapContext;
}

@end


@implementation ColorPicker

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
  }
  
  return self;
}

- (void)dealloc
{
  [self setColorWheelBitmapContext:nil];
}

- (void)drawRect:(CGRect)rect
{
  [[self colorWheelImage] drawAtPoint:CGPointMake(0, 0)];
}

#pragma mark - Touch events

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
  [self updateColorWithTouch:touch];
  return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
  [self updateColorWithTouch:touch];
  return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
  [self updateColorWithTouch:touch];
}

- (void)updateColorWithTouch:(UITouch *)touch
{
  CGPoint touchPoint = [touch locationInView:self];
  self.color = [self getPixelColorAtLocation:touchPoint];
  self.backgroundColor = self.color;
}

#pragma mark - Properties

- (CGContextRef)colorWheelBitmapContext
{
  if (_colorWheelBitmapContext == nil) {
    UIImage *colorWheelImage = [self colorWheelImage];
    
    _colorWheelBitmapContext = [self createBitmapContextOfSize:colorWheelImage.size];
    [self renderImage:colorWheelImage onContext:_colorWheelBitmapContext];
  }

  return _colorWheelBitmapContext;
}

- (void)setColorWheelBitmapContext:(CGContextRef)context
{
  if (_colorWheelBitmapContext) {
    free(CGBitmapContextGetData(_colorWheelBitmapContext));
    CGContextRelease(_colorWheelBitmapContext);
  }

  _colorWheelBitmapContext = context;
}

- (UIImage *)colorWheelImage
{
  return [UIImage imageNamed:@"colorWheel1.png"];
}

#pragma mark - Color picking

- (UIColor *)getPixelColorAtLocation:(CGPoint)point
{
  unsigned char *data = CGBitmapContextGetData([self colorWheelBitmapContext]);

  int imageWidth = [self colorWheelImage].size.width;
  int offset = 4 * ((imageWidth * round(point.y)) + round(point.x));

  CGFloat alpha = data[offset] / 255.0f;
  CGFloat red = data[offset + 1] / 255.0f;
  CGFloat green = data[offset + 2] / 255.0f;
  CGFloat blue = data[offset + 3] / 255.0f;

  return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)renderImage:(UIImage *)image onContext:(CGContextRef)context
{
  CGRect imageRenderingRect = {
    .origin = CGPointMake(0, 0),
    .size = image.size
  };
  CGContextDrawImage(context, imageRenderingRect, [image CGImage]);
}

- (CGContextRef)createBitmapContextOfSize:(CGSize)size
{
	int bitmapBytesPerRow = size.width * 4;
	int bitmapByteCount = bitmapBytesPerRow * size.height;

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

	void *bitmapData = malloc(bitmapByteCount);
	CGContextRef context = CGBitmapContextCreate(bitmapData, size.width, size.height, 8, bitmapBytesPerRow,
                                               colorSpace, kCGImageAlphaPremultipliedFirst);

	CGColorSpaceRelease(colorSpace);

	return context;
}

@end
