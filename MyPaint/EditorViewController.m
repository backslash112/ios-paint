#import "EditorViewController.h"
#import "CanvasViewController.h"


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

  [self selectPen];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)colorButtonTapped:(UIBarButtonItem *)button
{
  [self.colorPickerPopupController presentPopoverFromBarButtonItem:button
                                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                                          animated:YES];
}

- (IBAction)pencilButtonTapped:(id)sender
{
  [self selectPen];
}

- (IBAction)rollerButtonTapped:(id)sender {
  [self selectRoller];
}

- (IBAction)eraserButtonTapped:(id)sender {
  [self selectEraser];
}

#pragma mark - Tool presets

- (void)selectPen
{
  self.canvasViewController.strokeWidth = 1;
}

- (void)selectRoller
{
  self.canvasViewController.strokeWidth = 10;
}

- (void)selectEraser
{
  self.canvasViewController.strokeColor = [UIColor whiteColor];
  self.canvasViewController.strokeWidth = 10;
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
  // Don't need color picker anymore, so release memory
  self.colorPickerPopupController = nil;
}

#pragma mark - ColorPickerDelegate

- (void)colorPickerDidChangeColor:(ColorPicker *)colorPicker
{
  self.canvasViewController.strokeColor = colorPicker.color;
  self.colorButton.tintColor = colorPicker.color;
}

#pragma mark - Properties

- (UIPopoverController *)colorPickerPopupController
{
  if (_colorPickerPopupController == nil) {
    ColorPicker *colorPicker = [[ColorPicker alloc] init];
    colorPicker.delegate = self;
    
    UIViewController *colorPickerViewController = [[UIViewController alloc] init];
    [colorPickerViewController setView:colorPicker];

    _colorPickerPopupController = [[UIPopoverController alloc] initWithContentViewController:colorPickerViewController];
    _colorPickerPopupController.delegate = self;
    _colorPickerPopupController.popoverContentSize = colorPicker.frame.size;
  }

  return _colorPickerPopupController;
}

@end
