#import "EditorViewController.h"
#import "CanvasViewController.h"


@interface EditorViewController ()

@property (strong, nonatomic) CanvasViewController *canvasViewController;
@property (strong, nonatomic) UIPopoverController *colorPickerPopupController;
@property (strong, nonatomic) UIColor *color;

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
  self.colorPickerPopupController = nil;
  self.color = nil;
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

- (IBAction)rollerButtonTapped:(id)sender
{
  [self selectRoller];
}

- (IBAction)eraserButtonTapped:(id)sender
{
  [self selectEraser];
}

- (IBAction)trashButtonTapped:(id)sender
{
  UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                       message:@"Are you sure you want to start over?"
                                                      delegate:self
                                             cancelButtonTitle:@"No"
                                             otherButtonTitles:@"Yes", nil];
  [errorAlert show];
}

#pragma mark - Tool presets

- (void)selectPen
{
  [self highlightToolButton:self.pencilButton];
  self.canvasViewController.strokeColor = self.color;
  self.canvasViewController.strokeWidth = 1;
}

- (void)selectRoller
{
  [self highlightToolButton:self.rollerButton];
  self.canvasViewController.strokeColor = self.color;
  self.canvasViewController.strokeWidth = 10;
}

- (void)selectEraser
{
  [self highlightToolButton:self.eraserButton];
  self.canvasViewController.strokeColor = [UIColor whiteColor];
  self.canvasViewController.strokeWidth = 20;
}

- (void)highlightToolButton:(UIBarButtonItem *)buttonToHighlight
{
  NSArray *toolButtons = @[self.pencilButton, self.rollerButton, self.eraserButton];
  
  for (UIBarButtonItem *button in toolButtons) {
    if (button == buttonToHighlight) {
      UIColor *highlightColor = [UIColor colorWithRed:63.0f / 255.0f
                                                green:129.0f / 255.0f
                                                 blue:213.0f / 255.0f
                                                alpha:1.0];
      button.tintColor = highlightColor;
    } else {
      button.tintColor = [UIColor whiteColor];
    }
  }
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
  // Don't need color picker anymore, so release memory
  self.colorPickerPopupController = nil;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  enum { kNoButtonIndex, kYesButtonIndex };

  if (buttonIndex == kYesButtonIndex) {
    self.canvasViewController.painting = [[Painting alloc] init];
    [self.canvasViewController.view setNeedsDisplay];
  }
}

#pragma mark - ColorPickerDelegate

- (void)colorPickerDidChangeColor:(ColorPicker *)colorPicker
{
  self.canvasViewController.strokeColor = colorPicker.color;
  self.color = colorPicker.color;
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
