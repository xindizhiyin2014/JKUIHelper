//
//  JKKVOItem.m
//  JKKVOHelper
//
//  Created by JackLee on 2020/5/26.
//




#import "JKKVOItem.h"
#import "JKKVOObserver.h"
#import "NSObject+JKKVOHelper.h"
#import "JKKVOHelperMacro.h"

static void *jk_computed_observer_context = "jk_computed_observer_context";

@interface JKBaseKVOItem()
/// 观察者
@property (nonatomic, strong, nonnull, readwrite) JKKVOObserver *kvoObserver;
/// 被观察的对象
@property (nonatomic, weak, nullable, readwrite) __kindof NSObject *observered;
/// 被观察的对象的内存地址
@property (nonatomic, copy, nullable, readwrite)  NSString * observered_address;
/// 监听的keyPath
@property (nonatomic, copy, nonnull, readwrite) NSString *keyPath;
///监听选项
@property (nonatomic, assign, readwrite) NSKeyValueObservingOptions options;
/// 上下文
@property (nonatomic, nullable, readwrite) void *context;

@end

@implementation JKBaseKVOItem

- (BOOL)valid
{
    return self.kvoObserver.originObserver && self.observered;
}

@end

@interface JKKVOItem()
/// 回调
@property (nonatomic, copy, readwrite) void(^block)(NSString *keyPath, NSDictionary *change, void *context);

@end

@implementation JKKVOItem

/// 非数组的监听
+ (instancetype)initWith_kvoObserver:(nonnull JKKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                             options:(NSKeyValueObservingOptions)options
                             context:(nullable void *)context
                               block:(nullable void(^)(NSString *keyPath,  NSDictionary *change, void *context))block;
{
    __kindof JKKVOItem *item = [[self alloc] init];
    if (item) {
        item.kvoObserver = kvoObserver;
        kvoObserver.itemClassName = NSStringFromClass([self class]);
        item.observered = observered;
        item.observered_address = [NSString stringWithFormat:@"%p",observered];
        item.keyPath = keyPath;
        item.options = options;
        item.context = context;
        item.block = block;
    }
    return item;
}

@end


@interface JKKVOArrayElement()

@property (nonatomic, strong, nonnull, readwrite) __kindof NSObject *object;

@property (nonatomic, assign, readwrite) NSInteger oldIndex;

@property (nonatomic, assign, readwrite) NSInteger newIndex;

@end

@implementation JKKVOArrayElement

+ (instancetype)elementWithObject:(__kindof NSObject *)object
                         oldIndex:(NSInteger)oldIndex
                         newIndex:(NSInteger)newIndex
{
    JKKVOArrayElement *element = [[self alloc] init];
    if (element) {
        element.object = object;
        element.oldIndex = oldIndex;
        element.newIndex = newIndex;
    }
    return element;
}

@end

@implementation JKKVOArrayChangeModel

@end

@interface JKKVOArrayItem()

/// 被监听的属性对应的对象
@property (nonatomic, weak, nullable, readwrite) __kindof NSArray *observered_property;
/// 数组元素需要监听的keyPath的数组
@property (nonatomic, strong, nullable, readwrite) NSArray *elementKeyPaths;
/// 回调
@property (nonatomic, copy, readwrite) void(^detailBlock)(NSString *keyPath, NSDictionary *change, JKKVOArrayChangeModel *changedModel, void *context);
/// 被监听的元素map   key:element   value: 添加监听的次数
@property (nonatomic, strong, nonnull, readwrite) NSMapTable *observered_elementMap;

@end

@implementation JKKVOArrayItem

/// 数组的监听
+ (instancetype)initWith_kvoObserver:(nonnull JKKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                             context:(nullable void *)context
                             options:(NSKeyValueObservingOptions)options
                 observered_property:(nullable __kindof NSObject *)observered_property
                     elementKeyPaths:(nullable NSArray *)elementKeyPaths
                         detailBlock:(nullable void(^)(NSString *keyPath, NSDictionary *change, JKKVOArrayChangeModel *changedModel, void *context))detailBlock;
{
    JKKVOArrayItem *item = [[self alloc] init];
    if (item) {
        item.kvoObserver = kvoObserver;
        kvoObserver.itemClassName = NSStringFromClass([self class]);
        item.observered = observered;
        item.observered_address = [NSString stringWithFormat:@"%p",observered];
        item.keyPath = keyPath;
        item.context = context;
        item.options = options;
        item.observered_property = observered_property;
        item.elementKeyPaths = elementKeyPaths;
        item.detailBlock = detailBlock;
        item.observered_elementMap = [NSMapTable strongToStrongObjectsMapTable];
    }
    return item;
}

- (void)addObserverOfElement:(nonnull __kindof NSObject *)element
{
    if (!self.elementKeyPaths
        || self.elementKeyPaths.count == 0) {
        return;
    }
    NSNumber *value = [self.observered_elementMap objectForKey:element];
    if (value) {
        NSUInteger observeredCount = [value unsignedIntegerValue];
        observeredCount += self.elementKeyPaths.count;
        [self.observered_elementMap setObject:@(observeredCount) forKey:element];
    } else {
        for (NSString *keyPath in self.elementKeyPaths) {
            [element addObserver:self.kvoObserver forKeyPath:keyPath options:self.options context:self.context];
            self.kvoObserver.observerCount++;
        }
        NSUInteger observeredCount = self.elementKeyPaths.count;
        [self.observered_elementMap setObject:@(observeredCount) forKey:element];
    }
}

- (void)removeObserverOfElement:(nonnull __kindof NSObject *)element
{
    NSNumber *value = [self.observered_elementMap objectForKey:element];
    if (value) {
        NSUInteger observeredCount = [value unsignedIntegerValue];
        observeredCount -= self.elementKeyPaths.count;
        if (observeredCount > 0) {
            [self.observered_elementMap setObject:@(observeredCount) forKey:element];
        } else {
            for (NSString *keyPath in self.elementKeyPaths) {
                [element removeObserver:self.kvoObserver forKeyPath:keyPath context:self.context];
                self.kvoObserver.observerCount--;
            }
            [self.observered_elementMap removeObjectForKey:element];
        }
    }
}

- (nullable NSArray <JKKVOArrayElement *>*)kvoElementsWithElement:(nonnull __kindof NSObject *)element
{
    NSMutableArray *kvoElements = nil;
    NSArray *observered_property = self.observered_property;
    if (!observered_property || observered_property.count == 0) {
        return kvoElements;
    }
    [JKKVOItemManager lock];
    NSArray *elements = [observered_property copy];
    if ([elements containsObject:element]) {
        kvoElements = [NSMutableArray new];
        for (NSInteger i = 0; i < elements.count; i++) {
            __kindof NSObject *tmpElement = elements[i];
            if ([tmpElement isEqual:element]) {
                NSInteger oldIndex = i;
                NSInteger newIndex = i;
                JKKVOArrayElement *kvoElement = [JKKVOArrayElement elementWithObject:element oldIndex:oldIndex newIndex:newIndex];
                [kvoElements addObject:kvoElement];
            }
        }
    }
    [JKKVOItemManager unLock];
    return kvoElements;
}

@end

@interface JKKVOComputedItem()

@property (nonatomic, strong, readwrite) NSArray <NSString *>*dependentProperties;
/// 回调
@property (nonatomic, copy, readwrite) void(^block)(NSString *keyPath, NSDictionary *change, void *context);

@end

@implementation JKKVOComputedItem

+ (instancetype)initWith_kvoObserver:(nonnull JKKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                 dependentProperties:(NSArray <NSString *>*)dependentProperties
                               block:(nullable void(^)(NSString *keyPath,  NSDictionary *change, void *context))block
{
    JKKVOComputedItem *item = [[self alloc] init];
    if (item) {
        item.kvoObserver = kvoObserver;
        kvoObserver.itemClassName = NSStringFromClass([self class]);
        item.observered = observered;
        item.observered_address = [NSString stringWithFormat:@"%p",observered];
        item.keyPath = keyPath;
        item.dependentProperties = dependentProperties;
        item.block = block;
    }
    return item;
}

- (void)addDependentPropertiesObserver
{
    for (NSString *keyPath in self.dependentProperties) {
        [self.observered addObserver:self.kvoObserver forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:jk_computed_observer_context];
        self.kvoObserver.observerCount++;
    }
}

- (void)removeDependentPropertiesObserver
{
    for (NSString *keyPath in self.dependentProperties) {
        [self.observered removeObserver:self.kvoObserver forKeyPath:keyPath];
        self.kvoObserver.observerCount--;
    }
}

+ (void *)computedObserverContext
{
    return jk_computed_observer_context;
}

@end
