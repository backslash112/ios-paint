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
  [self strokeDidInsertAtIndex:[_strokes count] - 1];
}

- (void)insertStroke:(Stroke *)stroke atIndex:(NSInteger)index
{
  [_strokes insertObject:stroke atIndex:index];
  [self strokeDidInsertAtIndex:index];
}

- (void)removeStrokeAtIndex:(NSInteger)index
{
  [_strokes removeObjectAtIndex:index];
  [self strokeDidRemoveAtIndex:index];
}

- (void)removeLastStroke
{
  [_strokes removeLastObject];
  [self strokeDidRemoveAtIndex:[_strokes count]];
}

- (Stroke *)strokeAtIndex:(NSInteger)index
{
  return _strokes[index];
}

- (Stroke *)lastStroke
{
  return [_strokes lastObject];
}

#pragma mark - Delegate events

- (void)strokeDidInsertAtIndex:(NSInteger)index
{
  if ([self.delegate respondsToSelector:@selector(strokeDidInsertAtIndex:)]) {
    [self.delegate strokeDidInsertAtIndex:index];
  }
}

- (void)strokeDidRemoveAtIndex:(NSInteger)index
{
  if ([self.delegate respondsToSelector:@selector(strokeDidRemoveAtIndex:)]) {
    [self.delegate strokeDidRemoveAtIndex:index];
  }
}

@end
