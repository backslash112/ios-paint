@interface Stroke : NSObject

@property (strong, nonatomic) NSMutableArray *points;
@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) CGFloat width;

@end
