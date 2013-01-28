#import "EditorViewController.h"
#import "CanvasViewController.h"


@interface EditorViewController ()

@property (strong, nonatomic) UIPopoverController *colorPickerPopupController;
@property (strong, nonatomic) Painting *painting;

@end


@implementation EditorViewController {
  CanvasViewController *_canvasViewController;
  UIColor *_color;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _canvasViewController = [[CanvasViewController alloc] initWithNibName:nil bundle:nil];
    self.painting = [[Painting alloc] init];
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self addChildViewController:_canvasViewController];
  [self.view insertSubview:_canvasViewController.view belowSubview:self.toolbar];
  _canvasViewController.view.frame = self.view.frame;

  [self selectPen];
  [self activateUndoRedoButtons];
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

- (IBAction)pencilButtonTapped:(UIBarButtonItem *)sender
{
  [self selectPen];
}

- (IBAction)rollerButtonTapped:(UIBarButtonItem *)sender
{
  [self selectRoller];
}

- (IBAction)eraserButtonTapped:(UIBarButtonItem *)sender
{
  [self selectEraser];
}

- (IBAction)trashButtonTapped:(UIBarButtonItem *)sender
{
  UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                       message:@"Are you sure you want to start over?"
                                                      delegate:self
                                             cancelButtonTitle:@"No"
                                             otherButtonTitles:@"Yes", nil];
  [errorAlert show];
}

- (IBAction)undoButtonTapped:(UIBarButtonItem *)sender
{
  [self.painting.undoManager undo];
}

- (IBAction)redoButtonTapped:(UIBarButtonItem *)sender
{
  
}

#pragma mark - Tool presets

- (void)selectPen
{
  [self highlightToolButton:self.pencilButton];
  _canvasViewController.strokeColor = _color;
  _canvasViewController.strokeWidth = 1;
}

- (void)selectRoller
{
  [self highlightToolButton:self.rollerButton];
  _canvasViewController.strokeColor = _color;
  _canvasViewController.strokeWidth = 10;
}

- (void)selectEraser
{
  [self highlightToolButton:self.eraserButton];
  _canvasViewController.strokeColor = [UIColor whiteColor];
  _canvasViewController.strokeWidth = 20;
}

#pragma mark - Toolbar buttons highlighting/activation

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

- (void)activateUndoRedoButtons
{
  self.undoButton.enabled = [self.painting.undoManager canUndo];
  self.redoButton.enabled = [self.painting.undoManager canRedo];
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
    _canvasViewController.painting = [[Painting alloc] init];
    [_canvasViewController.view reloadData];
  }
}

#pragma mark - ColorPickerDelegate

- (void)colorPickerDidChangeColor:(ColorPicker *)colorPicker
{
  _canvasViewController.strokeColor = colorPicker.color;
  _color = colorPicker.color;
  self.colorButton.tintColor = colorPicker.color;
}

#pragma mark - Notifications

- (void)paintingDidChange:(NSNotification *)notification
{
  [self activateUndoRedoButtons];
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

- (void)setPainting:(Painting *)painting
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:NSUndoManagerCheckpointNotification
                                                object:_painting];
  
  _canvasViewController.painting = _painting = painting;

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(paintingDidChange:)
                                               name:NSUndoManagerCheckpointNotification
                                             object:_painting.undoManager];
}

@end
