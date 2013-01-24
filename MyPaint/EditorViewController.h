#import <UIKit/UIKit.h>
#import "ColorPicker.h"


@interface EditorViewController : UIViewController <UIPopoverControllerDelegate, ColorPickerDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorButton;

- (IBAction)colorButtonTapped:(UIBarButtonItem *)button;

@end
