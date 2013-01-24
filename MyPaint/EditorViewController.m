#import "EditorViewController.h"
#import "CanvasViewController.h"
#import "ColorPickerViewController.h"
#import "ColorPicker.h"


@interface EditorViewController ()

@property (strong, nonatomic) CanvasViewController *canvasViewController;
@property (strong, nonatomic) UIPopoverController *colorPickerPopupController;

@end


@implementation EditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {

  }
  
  return self;
}

- (void)dealloc
{
  self.canvasViewController = nil;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.canvasViewController = [[CanvasViewController alloc] initWithNibName:nil bundle:nil];
  [self addChildViewController:self.canvasViewController];
  [self.view insertSubview:self.canvasViewController.view belowSubview:self.toolbar];
  self.canvasViewController.view.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)colorButtonTapped:(UIBarButtonItem *)button
{
  [self.colorPickerPopupController presentPopoverFromBarButtonItem:button
                                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                                          animated:YES];
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
  // Don't need color picker anymore, so release memory
  self.colorPickerPopupController = nil;
}

#pragma mark - Properties

- (UIPopoverController *)colorPickerPopupController
{
  if (_colorPickerPopupController == nil) {
    //ColorPickerViewController *colorPickerViewController = [[ColorPickerViewController alloc] init];
    
    ColorPicker *cp = [[ColorPicker alloc] initWithFrame:CGRectMake(0, 0, 300, 340)];
    UIViewController *vc = [[UIViewController alloc] init];
    [vc setView:cp];

    _colorPickerPopupController = [[UIPopoverController alloc] initWithContentViewController:vc];
    _colorPickerPopupController.delegate = self;
    _colorPickerPopupController.popoverContentSize = cp.frame.size;
  }

  return _colorPickerPopupController;
}

@end
