#import "Stroke.h"


@implementation Stroke

#pragma mark - Properties

- (NSMutableArray *)points
{
  if (_points == nil) {
    _points = [[NSMutableArray alloc] init];
  }

  return _points;
}

@end
