//
//  NSObject+JKKVOHelper.h
//  JKKVOHelper
//
//  Created by JackLee on 2019/8/30.
//

#import <Foundation/Foundation.h>
#import "JKKVOItem.h"
#import "JKKVOItemManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JKKVOHelper)
/**
 添加keyPath监听
 
 @param observer 观察者
 @param keyPath keyPath
 @param options options
 @param block 回调
 */
- (void)jk_addObserver:(__kindof NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
             withBlock:(void(^)(NSDictionary *change, void *context))block;

/**
 添加keyPath监听，有context
 
 @param observer 观察者
 @param keyPath keyPath
 @param options options
 @param context context
 @param block 回调
 */
- (void)jk_addObserver:(__kindof NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(nullable void *)context
             withBlock:(void(^)(NSDictionary *change, void *context))block;


/// 添加一组keyPath监听，有context
/// @param observer 观察者
/// @param keyPaths keyPath数组
/// @param options options
/// @param context context
/// @param detailBlock 回调
- (void)jk_addObserver:(__kindof NSObject *)observer
           forKeyPaths:(NSArray <NSString *>*)keyPaths
               options:(NSKeyValueObservingOptions)options
               context:(nullable void *)context
       withDetailBlock:(void(^)(NSString *keyPath, NSDictionary *change, void *context))detailBlock;

/**
 添加keyPath监听,观察者是自己
 
 @param keyPath keyPath
 @param options options
 @param block 回调
 */
- (void)jk_addObserverForKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                       withBlock:(void(^)(NSDictionary *change, void *context))block;

/**
 添加keyPath监听,观察者是自己，有context
 
 @param keyPath keyPath
 @param options options
 @param context context
 @param block 回调
 */
- (void)jk_addObserverForKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                         context:(nullable void *)context
                       withBlock:(void(^)(NSDictionary *change, void *context))block;

/// 添加一组keyPath监听,观察者是自己,有context
/// @param keyPaths keyPath数组
/// @param options options
/// @param context context
/// @param detailBlock 回调
- (void)jk_addObserverForKeyPaths:(NSArray <NSString *>*)keyPaths
                          options:(NSKeyValueObservingOptions)options
                          context:(nullable void *)context
                  withDetailBlock:(void(^)(NSString *keyPath, NSDictionary *change, void *context))detailBlock;

/// 监听数组的变化，不监听数组元素属性的变化
/// @param keyPath keyPath，keyPath对应的属性是数组
/// @param options options
/// @param context context
/// @param block block
- (void)jk_addObserverOfArrayForKeyPath:(NSString *)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(nullable void *)context
                              withBlock:(void (^)(NSString *keyPath, NSDictionary *change, JKKVOArrayChangeModel *changedModel, void *context))block;

/// 监听数组的变化，同时监听数组元素属性的变化,观察者是自己
/// @param keyPath keyPath，keyPath对应的属性是数组
/// @param options options
/// @param context context
/// @param elementKeyPaths elementKeyPaths 数组的元素对应的keypath组成的数组
/// @param block block
- (void)jk_addObserverOfArrayForKeyPath:(NSString *)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(nullable void *)context
                        elementKeyPaths:(nullable NSArray <NSString *>*)elementKeyPaths
                              withBlock:(void (^)(NSString *keyPath, NSDictionary *change, JKKVOArrayChangeModel *changedModel, void *context))block;

/// 监听数组的变化，同时监听数组元素属性的变化
/// @param observer 观察者
/// @param keyPath keyPath keyPath，keyPath对应的属性是数组
/// @param options options
/// @param context context
/// @param elementKeyPaths elementKeyPaths 数组的元素对应的keypath组成的数组
/// @param block block
- (void)jk_addObserverOfArray:(__kindof NSObject *)observer
                      keyPath:(NSString *)keyPath
                      options:(NSKeyValueObservingOptions)options
                      context:(nullable void *)context
              elementKeyPaths:(nullable NSArray <NSString *>*)elementKeyPaths
                    withBlock:(void (^)(NSString *keyPath, NSDictionary *change, JKKVOArrayChangeModel *changedModel, void *context))block;

/**
 移除keyPath监听
 
 @param observer 观察者
 @param keyPath keyPath
 */
- (void)jk_removeObserver:(__kindof NSObject *)observer
               forKeyPath:(NSString *)keyPath;

/// 移除keyPath监听,有context
/// @param observer 观察者
/// @param keyPath keyPath
/// @param context context
- (void)jk_removeObserver:(__kindof NSObject *)observer
               forKeyPath:(NSString *)keyPath
                  context:(nullable void *)context;

/**
 移除某个observer下的对应的keyPath列表监听
 
 @param observer 观察者
 @param keyPaths keyPath组成的数组
 */
- (void)jk_removeObserver:(__kindof NSObject *)observer
              forKeyPaths:(NSArray <NSString *>*)keyPaths;

/**
 移除某个keyPath的obsevers对应的监听
 如果observers为nil，那么remove掉某个keyPath的所有obsevers对应的监听
 
 @param observers 观察者数组
 @param keyPath keyPath
 */
- (void)jk_removeObservers:(nullable NSArray <__kindof NSObject *>*)observers
                forKeyPath:(NSString *)keyPath;

/**
 移除特定观察者
 @param observer 观察者
*/
- (void)jk_removeObserver:(__kindof NSObject *)observer;

/**
 移除所有通过jk_前缀添加的观察者，默认在被观察的对象dealloc的时候调用
 */
- (void)jk_removeObservers;

/**
 所有的被监听的keyPath列表
 
 @return 被监听的keyPath组成的列表
 */
- (NSArray <NSString *>*)jk_observeredKeyPaths;

/// 监听某一个属性的所有监听者的列表
/// @param keyPath keyPath
- (NSArray <NSObject *>*)jk_observersOfKeyPath:(NSString *)keyPath;

/**
 某个观察者监听的keyPath组成的列表
 
 @param observer 观察者
 @return keyPath组成的列表
 */
- (NSArray <NSString *>*)jk_keyPathsObserveredBy:(__kindof NSObject *)observer;

/// 计算属性的配置 key:计算属性的属性名字  value:计算属性变化依赖的基础属性的属性名字
/// 支持的类型：CGSize,CGPoint,UIOffset,char,int,short,long,long long,unsigned char,unsigned int,unsigned short,unsigned long,unsigned long long,BOOL,Class
/// 不支持的类型：UCGRect,IEdgeInsets,CGAffineTransform,float,double,char*,SEL 可以通过NSValue封装的形式实现
- (NSDictionary <NSString *,NSArray *>*)jk_computedProperty_config;

/// 初始化计算属性配置信息
- (void)jk_initComputed;

@end

NS_ASSUME_NONNULL_END
