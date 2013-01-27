#import "Painting.h"


@interface Painting()

@property (strong, nonatomic) NSMutableArray *strokes;

@end


@implementation Painting

- (id)init
{
  self = [super init];
  if (self) {
    self.strokes = [[NSMutableArray alloc] init];
  }

  return self;
}

- (void)addStroke:(Stroke *)stroke
{
  [self.strokes addObject:stroke];
}

- (void)removeFirstStrokesCount:(NSInteger)count
{
  [self.strokes removeObjectsInRange:NSMakeRange(0, count)];
}

@end
