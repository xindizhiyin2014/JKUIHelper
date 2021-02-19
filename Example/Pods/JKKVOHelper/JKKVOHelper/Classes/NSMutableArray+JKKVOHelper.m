//
//  NSMutableArray+JKKVOHelper.m
//  JKKVOHelper
//
//  Created by JackLee on 2020/4/28.
//

#import "NSMutableArray+JKKVOHelper.h"
#import "JKKVOItem.h"
#import "JKKVOItemManager.h"

@implementation NSMutableArray (JKKVOHelper)

- (void)kvo_addObject:(id)anObject
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
#endif
    if (anObject) {
        NSArray <JKKVOArrayItem *>*items = [JKKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSInteger oldIndex = NSNotFound;
            NSInteger newIndex = [self count];
            JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
            changedModel.changeType = JKKVOArrayChangeTypeAddTail;
            JKKVOArrayElement *element = [JKKVOArrayElement elementWithObject:anObject oldIndex:oldIndex newIndex:newIndex];
            changedModel.changedElements = @[element];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(JKKVOArrayItem * _Nullable item) {
                [self addObject:anObject];
                if (item) {
                    [item addObserverOfElement:element];
                }
                return YES;
            }];
        } else {
          [self addObject:anObject];
        }
        
    }
}
- (void)kvo_insertObject:(id)anObject atIndex:(NSUInteger)index
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
    NSAssert(index <= self.count, @"make sure index <= self.count be YES");
#endif
    if (anObject
        && index <= self.count) {
        NSArray <JKKVOArrayItem *>*items = [JKKVOItemManager arrayItemsOfObservered_property:self];
         if (items.count > 0) {
             NSInteger oldIndex = NSNotFound;
             NSInteger newIndex = index;
             JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
             changedModel.changeType = JKKVOArrayChangeTypeAddAtIndex;
             JKKVOArrayElement *element = [JKKVOArrayElement elementWithObject:anObject oldIndex:oldIndex newIndex:newIndex];
             changedModel.changedElements = @[element];
             [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(JKKVOArrayItem * _Nullable item) {
                 [self insertObject:anObject atIndex:index];
                 if (item) {
                     [item addObserverOfElement:element];
                 }
                 return YES;
             }];
         } else {
           [self insertObject:anObject atIndex:index];
         }
    }
}

- (void)kvo_removeLastObject
{
#if DEBUG
    NSAssert(self.count > 0, @"make sure self.count > 0 be YES");
#endif
    if (self.count > 0) {
        NSArray <JKKVOArrayItem *>*items = [JKKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSInteger oldIndex = [self count] - 1;
            NSInteger newIndex = NSNotFound;
            JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
            changedModel.changeType = JKKVOArrayChangeTypeRemoveTail;
            JKKVOArrayElement *element = [JKKVOArrayElement elementWithObject:self.lastObject oldIndex:oldIndex newIndex:newIndex];
            changedModel.changedElements = @[element];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(JKKVOArrayItem * _Nullable item) {
                __kindof NSObject *element = self.lastObject;
                if (item) {
                    [item removeObserverOfElement:element];
                }
                [self removeLastObject];
                return YES;
            }];
        } else {
            [self removeLastObject];
        }
    }
}
- (void)kvo_removeObjectAtIndex:(NSUInteger)index
{
#if DEBUG
    NSAssert(index < self.count, @"make sure index < self.count be YES");
#endif
    if (index < self.count) {
        NSArray <JKKVOArrayItem *>*items = [JKKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSInteger oldIndex = index;
            NSInteger newIndex = NSNotFound;
            JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
            changedModel.changeType = JKKVOArrayChangeTypeRemoveAtIndex;
            JKKVOArrayElement *element = [JKKVOArrayElement elementWithObject:self[index] oldIndex:oldIndex newIndex:newIndex];
            changedModel.changedElements = @[element];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(JKKVOArrayItem * _Nullable item) {
                __kindof NSObject *element = self[oldIndex];
                if (item) {
                    [item removeObserverOfElement:element];
                }
                [self removeObjectAtIndex:index];
                return YES;
            }];
        } else {
            [self removeObjectAtIndex:index];
        }
    }
}

- (void)kvo_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
    NSAssert(index < self.count, @"make sure index < self.count be YES");
#endif
    if (anObject
        && index < self.count
        && ![self[index] isEqual:anObject]) {
        NSArray <JKKVOArrayItem *>*items = [JKKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSObject *oldObject = self[index];
            JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
            changedModel.changeType = JKKVOArrayChangeTypeReplace;
            JKKVOArrayElement *oldElement = [JKKVOArrayElement elementWithObject:oldObject oldIndex:index newIndex:NSNotFound];
            JKKVOArrayElement *newElement = [JKKVOArrayElement elementWithObject:anObject oldIndex:NSNotFound newIndex:index];
            changedModel.changedElements = @[oldElement,newElement];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(JKKVOArrayItem * _Nullable item) {
                [self replaceObjectAtIndex:index withObject:anObject];
                if (item) {
                    [item addObserverOfElement:anObject];
                }
                return YES;
            }];
        } else {
            [self replaceObjectAtIndex:index withObject:anObject];
        }
    }
}

- (void)kvo_addObjectsFromArray:(NSArray<id> *)otherArray
{
#if DEBUG
    NSAssert(otherArray.count > 0, @"make sure otherArray.count > 0 be YES");
#endif
    if (otherArray.count > 0) {
        NSArray <JKKVOArrayItem *>*items = [JKKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSMutableArray *array = [NSMutableArray new];
            for (NSInteger i = 0; i < otherArray.count; i++) {
                NSObject *object = otherArray[i];
                NSInteger oldIndex = NSNotFound;
                NSInteger newIndex = self.count + i;
                JKKVOArrayElement *element = [JKKVOArrayElement elementWithObject:object oldIndex:oldIndex newIndex:newIndex];
                [array addObject:element];
            }
            JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
            changedModel.changeType = JKKVOArrayChangeTypeAddTail;
            changedModel.changedElements = [array copy];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(JKKVOArrayItem * _Nullable item) {
                [self addObjectsFromArray:otherArray];
                if (item) {
                    for (JKKVOArrayElement *kvoElement in array) {
                        [item addObserverOfElement:kvoElement.object];
                    }
                }
                return YES;
            }];
        } else {
            [self addObjectsFromArray:otherArray];
        }
    }
}

- (void)kvo_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
#if DEBUG
    NSAssert(idx1 < self.count, @"make sure idx1 < self.count be YES");
    NSAssert(idx2 < self.count, @"make sure idx2 < self.count be YES");
#endif
    if (idx1 >= 0
        && idx2 >= 0
        && idx1 < self.count
        && idx2 < self.count
        && idx1 != idx2) {
        NSArray <JKKVOArrayItem *>*items = [JKKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSObject *object1 = self[idx1];
            NSInteger oldIndex1 = idx1;
            NSInteger newIndex1 = idx2;
            JKKVOArrayElement *element1 = [JKKVOArrayElement elementWithObject:object1 oldIndex:oldIndex1 newIndex:newIndex1];
            NSObject *object2 = self[idx2];
            NSInteger oldIndex2 = idx2;
            NSInteger newIndex2 = idx1;
            JKKVOArrayElement *element2 = [JKKVOArrayElement elementWithObject:object2 oldIndex:oldIndex2 newIndex:newIndex2];
            JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
            changedModel.changeType = JKKVOArrayChangeTypeReplace;
            changedModel.changedElements = @[element1,element2];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(JKKVOArrayItem * _Nullable item) {
                [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
                return YES;
            }];
        } else {
            [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        }
    }
}

- (void)kvo_removeAllObjects
{
    if (self.count > 0) {
        NSArray <JKKVOArrayItem *>*items = [JKKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSMutableArray *array = [NSMutableArray new];
            for (NSInteger i = 0; i < self.count; i++) {
                NSObject *object = self[i];
                NSInteger oldIndex = i;
                NSInteger newIndex = NSNotFound;
                JKKVOArrayElement *element = [JKKVOArrayElement elementWithObject:object oldIndex:oldIndex newIndex:newIndex];
                [array addObject:element];
            }
            JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
            changedModel.changeType = JKKVOArrayChangeTypeRemoveTail;
            changedModel.changedElements = [array copy];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(JKKVOArrayItem * _Nullable item) {
                if (item) {
                    for (JKKVOArrayElement *kvoElement in array) {
                        [item removeObserverOfElement:kvoElement.object];
                    }
                }
                [self removeAllObjects];
                return YES;
            }];
        } else {
            [self removeAllObjects];
        }
    }
}

- (void)kvo_removeObject:(id)anObject
{
#if DEBUG
    NSAssert(anObject, @"anObject can't be nil");
#endif
    if (anObject
        && [self containsObject:anObject]) {
        NSArray <JKKVOArrayItem *>*items = [JKKVOItemManager arrayItemsOfObservered_property:self];
        if (items.count > 0) {
            NSMutableArray *array = [NSMutableArray new];
            for (NSInteger i = 0; i < self.count; i++) {
                NSObject *object = self[i];
                if ([object isEqual:anObject]) {
                    NSInteger oldIndex = i;
                    NSInteger newIndex = NSNotFound;
                    JKKVOArrayElement *element = [JKKVOArrayElement elementWithObject:object oldIndex:oldIndex newIndex:newIndex];
                    [array addObject:element];
                }
            }
            JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
            changedModel.changeType = JKKVOArrayChangeTypeRemoveAtIndex;
            changedModel.changedElements = [array copy];
            [self invokeChangeWithItems:items changedModel:changedModel actionBlock:^BOOL(JKKVOArrayItem * _Nullable item) {
                if (item) {
                 for (JKKVOArrayElement *kvoElement in array) {
                        [item removeObserverOfElement:kvoElement.object];
                    }
                }
                [self removeObject:anObject];
                return YES;
            }];
        } else {
            [self removeObject:anObject];
        }
    }
}

- (void)invokeChangeWithItems:(NSArray<JKKVOArrayItem *>*)items
                 changedModel:(JKKVOArrayChangeModel *)changedModel
                  actionBlock:(BOOL(^)(JKKVOArrayItem * _Nullable item))actionBlock
{
    NSMutableArray *old_self = nil;
    BOOL hasAddedElement = NO;
    for (JKKVOArrayItem *item in items) {
        if (!old_self) {
            if ((item.options & NSKeyValueObservingOptionOld) == NSKeyValueObservingOptionOld) {
                 old_self = [self mutableCopy];
            }
        } else {
            break;
        }
    }
    for (JKKVOArrayItem *item in items) {
        if (!item.detailBlock) {
            if (actionBlock) {
                actionBlock(nil);
            }
            return;
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if ((item.options & NSKeyValueObservingOptionOld) == NSKeyValueObservingOptionOld) {
            dic[NSKeyValueChangeOldKey] = old_self;
        }
        if (!hasAddedElement) {
            if (actionBlock) {
               hasAddedElement = actionBlock(item);
            }
        }
        if ((item.options & NSKeyValueObservingOptionNew) == NSKeyValueObservingOptionNew) {
            dic[NSKeyValueChangeNewKey] = self;
        }
        [JKKVOItemManager jk_judgeCycleInvokeWithItem:item block:^{
            item.detailBlock(item.keyPath, dic, changedModel, item.context);
        }];
        
    }

}

@end
