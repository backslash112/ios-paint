#import "ColorPicker.h"


@interface EditorViewController : UIViewController
    <UIPopoverControllerDelegate, UIAlertViewDelegate, ColorPickerDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pencilButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rollerButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *eraserButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *undoButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *redoButton;

- (IBAction)colorButtonTapped:(UIBarButtonItem *)button;
- (IBAction)pencilButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)rollerButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)eraserButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)trashButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)undoButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)redoButtonTapped:(UIBarButtonItem *)sender;

@end
