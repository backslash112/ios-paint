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

- (void)dealloc
{
  self.strokes = nil;
}

- (void)addStroke:(Stroke *)stroke
{
  [self.strokes addObject:stroke];
}

@end
