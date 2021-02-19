//
//  JKKVOItem.h
//  JKKVOHelper
//
//  Created by JackLee on 2020/5/26.
//

#import <Foundation/Foundation.h>
#import "JKKVOObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKBaseKVOItem : NSObject

/// 观察者
@property (nonatomic, strong, nonnull, readonly) JKKVOObserver *kvoObserver;
/// 被观察者
@property (nonatomic, weak, nullable, readonly) __kindof NSObject *observered;
///被观察者的内存地址
@property (nonatomic, copy, nullable, readonly) NSString *observered_address;
/// 监听的keyPath
@property (nonatomic, copy, nonnull, readonly) NSString *keyPath;
///监听选项
@property (nonatomic, assign, readonly) NSKeyValueObservingOptions options;
/// 上下文
@property (nonatomic, nullable, readonly) void *context;
/// 是否有效
@property (nonatomic, assign, readonly) BOOL valid;
#if DEBUG
/// 正在处理的引起变化的回调的数量，每次回调开始自动加1，回调结束自动减1
@property (nonatomic, assign) NSUInteger handlingCount;
#endif

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

@interface JKKVOItem : JKBaseKVOItem

/// 回调
@property (nonatomic, copy, readonly) void(^block)(NSString *keyPath, NSDictionary *change, void *context);

/// 非数组的监听
+ (instancetype)initWith_kvoObserver:(nonnull JKKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                             options:(NSKeyValueObservingOptions)options
                             context:(nullable void *)context
                               block:(nullable void(^)(NSString *keyPath,  NSDictionary *change, void *context))block;

@end


typedef NS_ENUM(NSInteger,JKKVOArrayChangeType) {
    /// 缺省值 没有任何改变
    JKKVOArrayChangeTypeNone = 0,
    /// 根据index增加元素
    JKKVOArrayChangeTypeAddAtIndex,
    /// 尾部增加元素
    JKKVOArrayChangeTypeAddTail,
    /// 根据index移除元素
    JKKVOArrayChangeTypeRemoveAtIndex,
    /// 移除尾部元素
    JKKVOArrayChangeTypeRemoveTail,
    /// 替换元素
    JKKVOArrayChangeTypeReplace,
    /// 元素内容改变，指针不变
    JKKVOArrayChangeTypeElement,
};

@interface JKKVOArrayElement : NSObject

@property (nonatomic, strong, nonnull, readonly) __kindof NSObject *object;

@property (nonatomic, assign, readonly) NSInteger oldIndex;

@property (nonatomic, assign, readonly) NSInteger newIndex;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)elementWithObject:(__kindof NSObject *)object
                         oldIndex:(NSInteger)oldIndex
                         newIndex:(NSInteger)newIndex;

@end

@interface JKKVOArrayChangeModel : NSObject

@property (nonatomic, assign) JKKVOArrayChangeType changeType;

@property (nonatomic, strong) NSArray <JKKVOArrayElement *>*changedElements;

@end

@interface JKKVOArrayItem : JKBaseKVOItem

/// 被监听的属性对应的对象
@property (nonatomic, weak, nullable, readonly) __kindof NSArray *observered_property;
/// 数组元素需要监听的keyPath的数组
@property (nonatomic, strong, nullable, readonly) NSArray *elementKeyPaths;
/// 被监听的元素map   key:element   value: 添加监听的次数
@property (nonatomic, strong, nonnull, readonly) NSMapTable *observered_elementMap;
/// 回调
@property (nonatomic, copy, readonly) void(^detailBlock)(NSString *keyPath, NSDictionary *change, JKKVOArrayChangeModel *changedModel, void *context);

+ (instancetype)initWith_kvoObserver:(nonnull JKKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                             context:(nullable void *)context
                             options:(NSKeyValueObservingOptions)options
                 observered_property:(nullable __kindof NSObject *)observered_property
                     elementKeyPaths:(nullable NSArray *)elementKeyPaths
                         detailBlock:(nullable void(^)(NSString *keyPath, NSDictionary *change, JKKVOArrayChangeModel *changedModel, void *context))detailBlock;

/// 为数组中的元素添加指定的监听
/// @param element 数组元素
- (void)addObserverOfElement:(nonnull __kindof NSObject *)element;

/// 为数组中的元素移除指定的监听
/// @param element 数组元素
- (void)removeObserverOfElement:(nonnull __kindof NSObject *)element;

- (nullable NSArray <JKKVOArrayElement *>*)kvoElementsWithElement:(nonnull __kindof NSObject *)element;

@end


@interface JKKVOComputedItem : JKBaseKVOItem

/// 用来标记数据是否有变化
@property (nonatomic, assign) BOOL dirty;
/// 计算属性缓存的值
@property (nonatomic) void *value;
///计算属性缓存非NSObject对象的值
@property (nonatomic) NSValue *non_obj_value;
///value的类型，NSObject的默认为NSObject,非NSObject 为真实的类型
@property (nonatomic) const char *valueType;
/// 依赖的属性建立的item组成的数组
@property (nonatomic, strong, readonly) NSArray <NSString *>*dependentProperties;
/// 回调
@property (nonatomic, copy, readonly) void(^block)(NSString *keyPath, NSDictionary *change, void *context);

+ (instancetype)initWith_kvoObserver:(nonnull JKKVOObserver *)kvoObserver
                          observered:(nonnull __kindof NSObject *)observered
                             keyPath:(nonnull NSString *)keyPath
                 dependentProperties:(NSArray <NSString *>*)dependentProperties
                               block:(nullable void(^)(NSString *keyPath,  NSDictionary *change, void *context))block;
/// 添加对依赖属性的监听
- (void)addDependentPropertiesObserver;

/// 移除对依赖属性的监听
- (void)removeDependentPropertiesObserver;
/// 内部使用
+ (void *)computedObserverContext;

@end


NS_ASSUME_NONNULL_END
