#import "CanvasViewController.h"


@interface CanvasViewController ()

@end


@implementation CanvasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)loadView
{
  self.view = [[CanvasView alloc] init];
}

#pragma mark - Properties

- (void)setStrokes:(NSArray *)strokes
{
  _strokes = strokes;
  self.canvasView.strokes = _strokes;
}

- (CanvasView *)canvasView
{
  return (CanvasView *)self.view;
}

@end
