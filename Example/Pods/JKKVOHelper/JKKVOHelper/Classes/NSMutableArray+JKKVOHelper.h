//
//  NSMutableArray+JKKVOHelper.h
//  JKKVOHelper
//
//  Created by JackLee on 2020/4/28.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (JKKVOHelper)

- (void)kvo_addObject:(id)anObject;
- (void)kvo_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)kvo_removeLastObject;
- (void)kvo_removeObjectAtIndex:(NSUInteger)index;
- (void)kvo_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (void)kvo_addObjectsFromArray:(NSArray<id> *)otherArray;
- (void)kvo_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)kvo_removeAllObjects;
- (void)kvo_removeObject:(id)anObject;
//- (void)kvo_setNil:(NSMutableArray *_Nonnull*_Nonnull)array;
/*
- (void)kvo_removeObject:(ObjectType)anObject inRange:(NSRange)range;
- (void)kvo_removeObjectIdenticalTo:(ObjectType)anObject inRange:(NSRange)range;
- (void)kvo_removeObjectIdenticalTo:(ObjectType)anObject;
- (void)kvo_removeObjectsInArray:(NSArray<ObjectType> *)otherArray;
- (void)kvo_removeObjectsInRange:(NSRange)range;
- (void)kvo_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<ObjectType> *)otherArray range:(NSRange)otherRange;
- (void)kvo_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<ObjectType> *)otherArray;
- (void)kvo_setArray:(NSArray<ObjectType> *)otherArray;
- (void)kvo_sortUsingFunction:(NSInteger (NS_NOESCAPE *)(ObjectType,  ObjectType, void * _Nullable))compare context:(nullable void *)context;
- (void)kvo_sortUsingSelector:(SEL)comparator;

- (void)kvo_insertObjects:(NSArray<ObjectType> *)objects atIndexes:(NSIndexSet *)indexes;
- (void)kvo_removeObjectsAtIndexes:(NSIndexSet *)indexes;
- (void)kvo_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<ObjectType> *)objects;

- (void)kvo_setObject:(ObjectType)obj atIndexedSubscript:(NSUInteger)idx API_AVAILABLE(macos(10.8), ios(6.0), watchos(2.0), tvos(9.0));

- (void)kvo_sortUsingComparator:(NSComparator NS_NOESCAPE)cmptr API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
- (void)kvo_sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmptr API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
*/
@end

NS_ASSUME_NONNULL_END
