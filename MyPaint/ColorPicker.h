@protocol ColorPickerDelegate;


@interface ColorPicker : UIControl

@property (strong, nonatomic) UIColor *color;
@property (weak, nonatomic) id <ColorPickerDelegate> delegate;

@end


@protocol ColorPickerDelegate

- (void)colorPickerDidChangeColor:(ColorPicker *)colorPicker;

@end
