//
//  JKKVOItemManager.h
//  JKKVOHelper
//
//  Created by JackLee on 2019/10/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class JKBaseKVOItem,JKKVOItem,JKKVOArrayItem,JKKVOComputedItem,JKKVOObserver;

@interface JKKVOItemManager : NSObject

+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)init NS_UNAVAILABLE;

+ (instancetype)sharedManager;

+ (void)lock;

+ (void)unLock;

+ (void)addItem:(__kindof JKBaseKVOItem *)item;

+ (void)removeItem:(__kindof JKBaseKVOItem *)item;

/// 判断是否存在item
/// @param observer 观察者
/// @param observered 被观察者
/// @param keyPath keyPath
/// @param context context
+ (nullable __kindof JKBaseKVOItem *)isContainItemWithObserver:(__kindof NSObject *)observer
                                                    observered:(__kindof NSObject *)observered
                                                       keyPath:(NSString *)keyPath
                                                       context:(nullable void *)context;
/// 是否存在JKKVOArrayItem
/// @param observer 观察者
/// @param observered 被观察者
/// @param keyPath keyPath
/// @param context context
+ (nullable JKKVOArrayItem *)isContainArrayItemWithObserver:(__kindof NSObject *)observer
                                                 observered:(__kindof NSObject *)observered
                                                    keyPath:(NSString *)keyPath
                                                    context:(nullable void *)context;
/// 是否存在JKKVOArrayItem
/// @param observer 观察者
/// @param observered 被观察者
/// @param keyPath keyPath
+ (nullable JKKVOComputedItem *)isContainComputedItemWithObserver:(__kindof NSObject *)observer
                                                       observered:(__kindof NSObject *)observered
                                                          keyPath:(NSString *)keyPath;

/// 是否存在item
/// @param observer 观察者
/// @param observered 被观察者
+ (BOOL)isContainItemWithObserver:(__kindof NSObject *)observer
                       observered:(__kindof NSObject *)observered;

/// 判断是否存在item JKKVOItem,JKKVOArrayItem,JKKVOComputedItem
/// @param kvoObserver 观察者
/// @param observered 被观察者
/// @param keyPath keyPath
/// @param context context
+ (nullable __kindof JKBaseKVOItem *)isContainItemWith_kvoObserver:(JKKVOObserver *)kvoObserver
                                                        observered:(__kindof NSObject *)observered
                                                           keyPath:(NSString *)keyPath
                                                           context:(nullable void *)context;
/// 获取item列表
/// @param observer 观察者
/// @param observered 被观察者
/// @param keyPath keyPath
+ (NSArray <__kindof JKBaseKVOItem *>*)itemsWithObserver:(__kindof NSObject *)observer
                                              observered:(__kindof NSObject *)observered
                                                 keyPath:(nullable NSString *)keyPath;

/// 获取item列表
/// @param observered 被观察者
+ (NSArray <__kindof JKBaseKVOItem *>*)itemsOfObservered:(__kindof NSObject *)observered;

/// 获取item列表
/// @param observered 被观察者
/// @param keyPath keyPath
+ (NSArray <__kindof JKBaseKVOItem *>*)itemsOfObservered:(__kindof NSObject *)observered
                                                 keyPath:(nullable NSString *)keyPath;
/// 获取item列表
/// @param observer 观察者
/// @param observered 被观察者
+ (NSArray <__kindof JKBaseKVOItem *>*)itemsOfObserver:(__kindof NSObject *)observer
                                            observered:(__kindof NSObject *)observered;

/// 获取item列表
/// @param kvoObserver 真正的观察者
/// @param observered 被观察者
+ (NSArray <__kindof JKBaseKVOItem *>*)itemsOf_kvoObserver:(__kindof NSObject *)kvoObserver
                                                observered:(__kindof NSObject *)observered;

/// 获取JKKVOArrayItem列表
/// @param observered_property 被观察者对应的属性对象
+ (NSArray <JKKVOArrayItem *>*)arrayItemsOfObservered_property:(__kindof NSObject *)observered_property;

/// 获取监听者列表
/// @param observered 被观察者
/// @param keyPath keyPath
+ (NSArray <__kindof NSObject *>*)observersOfObservered:(__kindof NSObject *)observered
                                                keyPath:(nullable NSString *)keyPath;

/// 获取被观察的keyPath列表
/// @param observered 被观察者
+ (NSArray <NSString *>*)observeredKeyPathsOfObservered:(__kindof NSObject *)observered;

/// 获取被观察keyPath列表
/// @param observered 被观察者
/// @param observer 观察者
+ (NSArray <NSString *>*)observeredKeyPathsOfObserered:(__kindof NSObject *)observered
                                              observer:(__kindof NSObject *)observer;

/// 获取被观察的keyPath列表
/// @param kvoObserver 被观察者
+ (NSArray <NSString *>*)observeredKeyPathsOf_kvoObserver:(JKKVOObserver *)kvoObserver
                                               observered:(__kindof NSObject *)observered;

/// 获取item.observered 为nil的item列表
/// @param observered 被观察者
+ (NSArray <__kindof JKBaseKVOItem *>*)dealloc_itemsOfObservered:(__kindof NSObject *)observered;

/**
 实例方法替换
 
 @param targetClass targetClass
 @param originalSel 源方法
 @param swizzledSel 替换方法
 */
+ (void)jk_exchangeInstanceMethod:(Class)targetClass
                      originalSel:(SEL)originalSel
                      swizzledSel:(SEL)swizzledSel;
/// 判断是否出现了循环调用
+ (void)jk_judgeCycleInvokeWithItem:(__kindof JKBaseKVOItem *)item
                              block:(void(^)(void))block;
@end

NS_ASSUME_NONNULL_END
