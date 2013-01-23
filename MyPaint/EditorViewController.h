#import <UIKit/UIKit.h>


@interface EditorViewController : UIViewController <UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)colorButtonTapped:(UIBarButtonItem *)button;

@end
