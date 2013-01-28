#import "Painting.h"


@implementation Painting {
  NSMutableArray *_strokes;
}

- (id)init
{
  NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *docsDir = [dirPaths objectAtIndex:0];
  NSString *dataFile = [docsDir stringByAppendingPathComponent:@"remove_me.doc"];
  
  self = [super initWithFileURL:[NSURL fileURLWithPath:dataFile]];
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

@end
