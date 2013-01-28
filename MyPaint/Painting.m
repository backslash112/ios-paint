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

#pragma mark - Public interface

- (NSInteger)numberOfStrokes
{
  return [_strokes count];
}

- (void)addStroke:(Stroke *)stroke
{
  [_strokes addObject:stroke];
  NSInteger indexOfStrokeAdded = [_strokes count] - 1;

  [[self.undoManager prepareWithInvocationTarget:self] removeLastStroke];

  [self strokeDidInsertAtIndex:indexOfStrokeAdded];
}

- (void)removeLastStroke
{
  [[self.undoManager prepareWithInvocationTarget:self] addStroke:[self lastStroke]];
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

#pragma mark - Properties

- (NSUndoManager *)undoManager
{
  if (_undoManager == nil) {
    _undoManager = [[NSUndoManager alloc] init];
  }

  return _undoManager;
}

@end
