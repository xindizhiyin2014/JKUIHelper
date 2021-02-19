//
//  JKKVOItemManager.m
//  JKKVOHelper
//
//  Created by JackLee on 2019/10/14.
//

#import "JKKVOItemManager.h"
#import <objc/runtime.h>
#import "JKKVOItem.h"
static const void *jk_kvo_items_key = "jk_kvo_items_key";
static const void *jk_kvo_computedItems_key = "jk_kvo_computedItems_key";


@interface NSObject (JKKVOItemManager)

@property (nonatomic, strong) NSMutableArray <__kindof JKKVOItem *>*jk_kvo_items;
/// 计算属性监听的items
@property (nonatomic, strong) NSMutableArray <JKKVOComputedItem *>*jk_kvo_computedItems;

@end

@implementation NSObject(JKKVOItemManager)
#pragma mark - - setter - -
- (void)setJk_kvo_items:(NSMutableArray<__kindof JKKVOItem *> *)jk_kvo_items
{
    objc_setAssociatedObject(self, jk_kvo_items_key, jk_kvo_items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setJk_kvo_computedItems:(NSMutableArray<JKKVOComputedItem *> *)jk_kvo_computedItems
{
    objc_setAssociatedObject(self, jk_kvo_computedItems_key, jk_kvo_computedItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma - - getter - -
- (NSMutableArray<__kindof JKKVOItem *> *)jk_kvo_items
{
    NSMutableArray *tmpArray = objc_getAssociatedObject(self, jk_kvo_items_key);
    if (!tmpArray) {
        tmpArray = [NSMutableArray new];
        [self setJk_kvo_items:tmpArray];
    }
    return tmpArray;
}

- (NSMutableArray<JKKVOComputedItem *> *)jk_kvo_computedItems
{
    NSMutableArray *tmpArray = objc_getAssociatedObject(self, jk_kvo_computedItems_key);
    if (!tmpArray) {
        tmpArray = [NSMutableArray new];
        [self setJk_kvo_computedItems:tmpArray];
    }
    return tmpArray;
}

@end

#pragma mark - - JKKVOItemManager - -

@interface JKKVOItemManager()

/// 所有的JKKVOArrayItem
@property (nonatomic, strong) NSMutableArray <JKKVOArrayItem *>*arrayItems;

@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation JKKVOItemManager

+ (instancetype)sharedManager
{
    static JKKVOItemManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
        _manager.lock = [[NSRecursiveLock alloc] init];
        _manager.arrayItems = [NSMutableArray new];
    });
    return _manager;
}

+ (void)lock
{
    [[JKKVOItemManager sharedManager].lock lock];
}

+ (void)unLock
{
    [[JKKVOItemManager sharedManager].lock unlock];
}

+ (void)addItem:(__kindof JKBaseKVOItem *)item
{
    if ([item isKindOfClass:[JKKVOArrayItem class]]) {
        [self addArrayItem:item];
    }  else if ([item isKindOfClass:[JKKVOComputedItem class]]) {
        [self addComputedItem:item];
    } else if ([item isKindOfClass:[JKKVOItem class]]) {
        [self addKVOItem:item];
    }
}

+ (void)removeItem:(__kindof JKBaseKVOItem *)item
{
    if ([item isKindOfClass:[JKKVOArrayItem class]]) {
        [self removeArrayItem:item];
    } else if ([item isKindOfClass:[JKKVOComputedItem class]]) {
        [self removeComputedItem:item];
    } else if ([item isKindOfClass:[JKKVOItem class]]) {
        [self removeKVOItem:item];
    }
}

+ (void)addArrayItem:(JKKVOArrayItem *)arrayItem
{
    if (![[JKKVOItemManager sharedManager].arrayItems containsObject:arrayItem]) {
        [[JKKVOItemManager sharedManager].arrayItems addObject:arrayItem];
    }
}

+ (void)addComputedItem:(JKKVOComputedItem *)computedItem
{
    if (computedItem
        && computedItem.observered
        && ![computedItem.observered.jk_kvo_computedItems containsObject:computedItem]) {
        [computedItem.observered.jk_kvo_computedItems addObject:computedItem];
    }
}

+ (void)addKVOItem:(__kindof JKKVOItem *)kvoItem
{
    if (kvoItem
        && kvoItem.observered
        && ![kvoItem.observered.jk_kvo_items containsObject:kvoItem]) {
        [kvoItem.observered.jk_kvo_items addObject:kvoItem];
    }
}

+ (void)removeArrayItem:(JKKVOArrayItem *)arrayItem
{
   if ([[JKKVOItemManager sharedManager].arrayItems containsObject:arrayItem]) {
        [[JKKVOItemManager sharedManager].arrayItems removeObject:arrayItem];
    }
}

+ (void)removeComputedItem:(JKKVOComputedItem *)computedItem
{
    if (computedItem
        && computedItem.observered
        && [computedItem.observered.jk_kvo_computedItems containsObject:computedItem]) {
        [computedItem.observered.jk_kvo_computedItems removeObject:computedItem];
    }
}

+ (void)removeKVOItem:(JKKVOItem *)kvoItem
{
   if (kvoItem
       && kvoItem.observered
       && [kvoItem.observered.jk_kvo_items containsObject:kvoItem]) {
       [kvoItem.observered.jk_kvo_items removeObject:kvoItem];
   }
}

+ (nullable __kindof JKBaseKVOItem *)isContainItemWithObserver:(__kindof NSObject *)observer
                                                    observered:(__kindof NSObject *)observered
                                                       keyPath:(NSString *)keyPath
                                                       context:(nullable void *)context
{
    if (!observer || !observered || !keyPath) {
        return nil;
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    [self unLock];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]
            && [keyPath isEqualToString:item.keyPath]
            && context == item.context) {
            return item;
        }
    }
    return nil;
}

+ (nullable JKKVOArrayItem *)isContainArrayItemWithObserver:(__kindof NSObject *)observer
                                                 observered:(__kindof NSObject *)observered
                                                    keyPath:(NSString *)keyPath
                                                    context:(nullable void *)context
{
  if (!observer || !observered || !keyPath) {
        return nil;
    }
    [self lock];
    NSArray *items = [[JKKVOItemManager sharedManager].arrayItems copy];
    [self unLock];
    for (JKKVOArrayItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]
            && [keyPath isEqualToString:item.keyPath]
            && context == item.context) {
            return item;
        }
    }
    return nil;
}

+ (nullable JKKVOComputedItem *)isContainComputedItemWithObserver:(__kindof NSObject *)observer
                                                       observered:(__kindof NSObject *)observered
                                                          keyPath:(NSString *)keyPath
{
    if (!observer || !observered || !keyPath) {
        return nil;
    }
    [self lock];
    NSArray <JKKVOComputedItem *>*jk_kvo_computedItems = [observered.jk_kvo_computedItems copy];
    [self unLock];
    for (__kindof JKKVOComputedItem *item in jk_kvo_computedItems) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]
            && [keyPath isEqualToString:item.keyPath]) {
            return item;
        }
    }
    return nil;
}

+ (BOOL)isContainItemWithObserver:(__kindof NSObject *)observer
                       observered:(__kindof NSObject *)observered
{
    if (!observer || !observered) {
        return NO;
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    [self unLock];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            return YES;
        }
    }
    return NO;
}

+ (nullable __kindof JKBaseKVOItem *)isContainItemWith_kvoObserver:(JKKVOObserver *)kvoObserver
                                                        observered:(__kindof NSObject *)observered
                                                           keyPath:(NSString *)keyPath
                                                           context:(nullable void *)context
{
 if (!kvoObserver || !observered || !keyPath) {
        return nil;
    }
    if ([kvoObserver.itemClassName isEqualToString:NSStringFromClass([JKKVOArrayItem class])]) {
        [self lock];
        NSMutableArray *items = [[JKKVOItemManager sharedManager].arrayItems copy];
        [self unLock];
        for (JKKVOArrayItem *item in items) {
            if (item.valid
                && [kvoObserver isEqual:item.kvoObserver]
                && context == item.context) {
                return item;
            }
        }
        return nil;
    } else if ([kvoObserver.itemClassName isEqualToString:NSStringFromClass([JKKVOComputedItem class])]) {
        [self lock];
        NSMutableArray <JKKVOItem *>*items = [observered.jk_kvo_computedItems copy];
        [self unLock];
        for (__kindof JKKVOItem *item in items) {
            if (item.valid
                && [kvoObserver isEqual:item.kvoObserver]
                && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
                return item;
            }
        }
        return nil;
    } else if ([kvoObserver.itemClassName isEqualToString:NSStringFromClass([JKKVOItem class])]) {
        [self lock];
        NSMutableArray *items = [observered.jk_kvo_items copy];
        [self unLock];
         for (__kindof JKKVOItem *item in items) {
               if (item.valid
                   && [kvoObserver isEqual:item.kvoObserver]
                   && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]
                   && [keyPath isEqualToString:item.keyPath]
                   && context == item.context) {
                   return item;
               }
           }
        return nil;
    }
    return nil;
}

+ (NSArray <__kindof JKBaseKVOItem *>*)itemsWithObserver:(__kindof NSObject *)observer
                                              observered:(__kindof NSObject *)observered
                                                 keyPath:(nullable NSString *)keyPath
{
    if (!observer || !observered) {
        return @[];
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (keyPath) {
                if ([keyPath isEqualToString:item.keyPath]) {
                    if (![tmpArray containsObject:item]) {
                        [tmpArray addObject:item];
                    }
                }
            } else {
                if (![tmpArray containsObject:item]) {
                    [tmpArray addObject:item];
                }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <__kindof JKBaseKVOItem *>*)itemsOfObservered:(__kindof NSObject *)observered
{
    return [self itemsOfObservered:observered keyPath:nil];
}

+ (NSArray <__kindof JKBaseKVOItem *>*)itemsOfObservered:(__kindof NSObject *)observered
                                                 keyPath:(nullable NSString *)keyPath
{
    if (!observered) {
        return @[];
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (keyPath) {
                if ([keyPath isEqualToString:item.keyPath]) {
                    if (![tmpArray containsObject:item]) {
                        [tmpArray addObject:item];
                    }
                }
            } else {
               if (![tmpArray containsObject:item]) {
                   [tmpArray addObject:item];
               }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <__kindof JKBaseKVOItem *>*)itemsOfObserver:(__kindof NSObject *)observer
                                            observered:(__kindof NSObject *)observered
{
    if (!observer) {
        return @[];
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observer] isEqualToString:item.kvoObserver.originObserver_address]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (![tmpArray containsObject:item]) {
                [tmpArray addObject:item];
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <__kindof JKBaseKVOItem *>*)itemsOf_kvoObserver:(__kindof NSObject *)kvoObserver
                                                observered:(__kindof NSObject *)observered
{
    if (!kvoObserver) {
        return @[];
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [kvoObserver isEqual:item.kvoObserver]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (![tmpArray containsObject:item]) {
                [tmpArray addObject:item];
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <JKKVOArrayItem *>*)arrayItemsOfObservered_property:(__kindof NSObject *)observered_property
{
  if (!observered_property) {
        return @[];
    }
    [self lock];
    NSArray *items = [[JKKVOItemManager sharedManager].arrayItems copy];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (JKKVOArrayItem *item in items) {
        if (item.valid
            && [observered_property isEqual:item.observered_property]) {
            if (![tmpArray containsObject:item]) {
                [tmpArray addObject:item];
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <__kindof NSObject *>*)observersOfObservered:(__kindof NSObject *)observered
                                                keyPath:(nullable NSString *)keyPath
{
    if (!observered) {
        return @[];
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    NSMutableSet *set = [NSMutableSet new];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (keyPath) {
                if ([keyPath isEqualToString:item.keyPath]) {
                    [set addObject:item.kvoObserver.originObserver];
                }
            } else {
               [set addObject:item.kvoObserver.originObserver];
            }
        }
    }
    [self unLock];
    return [set allObjects];
}

+ (NSArray <NSString *>*)observeredKeyPathsOfObservered:(__kindof NSObject *)observered
{
    if (!observered) {
        return @[];
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (item.keyPath) {
                if (![tmpArray containsObject:item.keyPath]) {
                    [tmpArray addObject:item.keyPath];
                }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <NSString *>*)observeredKeyPathsOfObserered:(__kindof NSObject *)observered
                                              observer:(__kindof NSObject *)observer
{
    if (!observer || !observered) {
        return @[];
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]
            && [[NSString stringWithFormat:@"%p",observer]
                isEqualToString:item.kvoObserver.originObserver_address]) {
            if (item.keyPath) {
                if (![tmpArray containsObject:item.keyPath]) {
                    [tmpArray addObject:item.keyPath];
                }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <NSString *>*)observeredKeyPathsOf_kvoObserver:(JKKVOObserver *)kvoObserver
                                               observered:(__kindof NSObject *)observered
{
    if (!kvoObserver || !observered) {
        return @[];
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof JKBaseKVOItem *item in items) {
        if (item.valid
            && [kvoObserver isEqual:item.kvoObserver]
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (item.keyPath) {
                if (![tmpArray containsObject:item.keyPath]) {
                    [tmpArray addObject:item.keyPath];
                }
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

+ (NSArray <__kindof JKBaseKVOItem *>*)dealloc_itemsOfObservered:(__kindof NSObject *)observered
{
    if (!observered) {
        return @[];
    }
    [self lock];
    NSMutableArray *items = [self allItemsOfObservered:observered];
    NSArray *jk_kvo_computedItems = [observered.jk_kvo_computedItems copy];
    [items addObjectsFromArray:jk_kvo_computedItems];
    [items addObjectsFromArray:[JKKVOItemManager sharedManager].arrayItems];
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (__kindof JKBaseKVOItem *item in items) {
        if (!item.valid
            && [[NSString stringWithFormat:@"%p",observered] isEqualToString:item.observered_address]) {
            if (![tmpArray containsObject:item]) {
               [tmpArray addObject:item];
            }
        }
    }
    [self unLock];
    return [tmpArray copy];
}

#pragma mark - - private method - -

/// observered对应的所有的item，不进行有效性校验
/// @param observered observered
+ (NSMutableArray <__kindof JKKVOItem *>*)allItemsOfObservered:(__kindof NSObject *)observered
{
    NSArray *jk_kvo_items = [observered.jk_kvo_items copy];
    NSMutableArray *items = [NSMutableArray arrayWithArray:jk_kvo_items];
    return items;
}
/**
 根据内存地址转换对应的对象

 @param addressStr 内存地址
 @return 转换后的对象
 */
//#pragma clang diagnostic ignored "-Wshorten-64-to-32"
//+ (id)objectWithAddressStr:(NSString *)addressStr
//{
//    addressStr = [addressStr hasPrefix:@"0x"] ? addressStr : [@"0x" stringByAppendingString:addressStr];
//    uintptr_t hex = strtoull(addressStr.UTF8String, NULL, 0);
//    id object = nil;
//    @try {
//        object = (__bridge id)(void *)hex;
//    } @catch (NSException *exception) {
//#if DEBUG
//        NSLog(@"JKKVOHelper exception %@",exception);
//#endif
//    } @finally {
//
//    }
//    return object;
//}

/**
 实例方法替换
 
 @param targetClass targetClass
 @param originalSel 源方法
 @param swizzledSel 替换方法
 */
+ (void)jk_exchangeInstanceMethod:(Class)targetClass
                   originalSel:(SEL)originalSel
                   swizzledSel:(SEL)swizzledSel
{
    Method originalMethod = class_getInstanceMethod(targetClass, originalSel);
    Method swizzledMethod = class_getInstanceMethod(targetClass, swizzledSel);
    
    // 这里用这个方法做判断，看看origin方法是否有实现，如果没实现，直接用我们自己的方法，如果有实现，则进行交换
    BOOL isAddMethod =
    class_addMethod(targetClass,
                    originalSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (isAddMethod) {
        class_replaceMethod(targetClass,
                            swizzledSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)jk_judgeCycleInvokeWithItem:(__kindof JKBaseKVOItem *)item
                              block:(void(^)(void))block
{
#if DEBUG
    item.handlingCount++;
    if (item.handlingCount > 30) {
        NSLog(@"you have cycle invoke! observered:%p,class:%@,keyPath:%@",item.observered,NSStringFromClass([item.observered class]),item.keyPath);
        NSAssert(NO, @"you have cycle invoke!");
    }
#endif
    if (block) {
        block();
    }
#if DEBUG
    item.handlingCount--;
#endif
}
@end
