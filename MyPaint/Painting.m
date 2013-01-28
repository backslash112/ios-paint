#import "Painting.h"


@implementation Painting {
  NSMutableArray *_strokes;
}

- (id)init
{
  self = [super init];
  if (self) {
    _strokes = [[NSMutableArray alloc] init];
  }

  return self;
}

- (NSInteger)numberOfStrokes
{
  return [_strokes count];
}

- (void)addStroke:(Stroke *)stroke
{
  [_strokes addObject:stroke];
}

- (void)insertStroke:(Stroke *)stroke atIndex:(NSInteger)index
{
  [_strokes insertObject:stroke atIndex:index];
}

- (void)removeStrokeAtIndex:(NSInteger)index
{
  [_strokes removeObjectAtIndex:index];
}

- (Stroke *)strokeAtIndex:(NSInteger)index
{
  return _strokes[index];
}

- (Stroke *)lastStroke
{
  return [_strokes lastObject];
}

@end
