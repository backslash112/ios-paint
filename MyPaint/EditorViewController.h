#import <UIKit/UIKit.h>
#import "ColorPicker.h"


@interface EditorViewController : UIViewController
    <UIPopoverControllerDelegate, UIAlertViewDelegate, ColorPickerDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pencilButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rollerButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *eraserButton;

- (IBAction)colorButtonTapped:(UIBarButtonItem *)button;
- (IBAction)pencilButtonTapped:(id)sender;
- (IBAction)rollerButtonTapped:(id)sender;
- (IBAction)eraserButtonTapped:(id)sender;
- (IBAction)trashButtonTapped:(id)sender;

@end
