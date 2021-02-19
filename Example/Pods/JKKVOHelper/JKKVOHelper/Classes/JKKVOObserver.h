//
//  JKKVOObserver.h
//  JKKVOHelper
//
//  Created by JackLee on 2020/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKKVOObserver : NSObject

@property (nonatomic, weak, nullable, readonly) __kindof NSObject *originObserver;
@property (nonatomic, copy, nullable, readonly) NSString *originObserver_address;
@property (nonatomic, assign) NSUInteger observerCount;
@property (nonatomic, copy) NSString *itemClassName;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)initWithOriginObserver:(__kindof NSObject *)originObserver;

@end

NS_ASSUME_NONNULL_END
