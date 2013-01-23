#import <Foundation/Foundation.h>


@interface Stroke : NSObject

@property (strong, nonatomic) NSArray *points;
@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) CGFloat width;

@end
