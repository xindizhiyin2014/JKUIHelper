//
//  JKKVOObserver.m
//  JKKVOHelper
//
//  Created by JackLee on 2020/5/26.
//

#import "JKKVOObserver.h"
#import "JKKVOItemManager.h"
#import "JKKVOItem.h"

@interface JKKVOArrayItem(Private)

@property (nonatomic, weak, nullable, readwrite) __kindof NSObject *observered_property;

@end

@implementation JKKVOArrayItem(Private)
@dynamic observered_property;

@end

@interface JKKVOObserver()

@property (nonatomic, weak, nullable, readwrite) __kindof NSObject *originObserver;
@property (nonatomic, copy, nullable, readwrite) NSString *originObserver_address;

@end

@implementation JKKVOObserver

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       Class class = [JKKVOObserver class];
        SEL observeValueForKeyPath = @selector(observeValueForKeyPath:ofObject:change:context:);
        SEL jk_ObserveValueForKeyPath = @selector(jkhook_observeValueForKeyPath:ofObject:change:context:);
        [JKKVOItemManager jk_exchangeInstanceMethod:class originalSel:observeValueForKeyPath swizzledSel:jk_ObserveValueForKeyPath];
    });
}

+ (instancetype)initWithOriginObserver:(__kindof NSObject *)originObserver
{
    JKKVOObserver *kvoObserver = [[self alloc] init];
    if (kvoObserver) {
        kvoObserver.originObserver = originObserver;
        kvoObserver.originObserver_address = [NSString stringWithFormat:@"%p",originObserver];
        kvoObserver.observerCount = 1;
    }
    return kvoObserver;
}

- (void)jkhook_observeValueForKeyPath:(NSString *)keyPath
                             ofObject:(id)object
                               change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                              context:(void *)context
{
    if ([object isKindOfClass:[NSObject class]]) {
        JKBaseKVOItem *item = [JKKVOItemManager isContainItemWith_kvoObserver:self observered:object keyPath:keyPath context:context];
        if (!item
            || !item.valid) {
            return;
        }
        if ([item isKindOfClass:[JKKVOArrayItem class]]) {
            JKKVOArrayItem *arrayItem = (JKKVOArrayItem *)item;
            NSObject *observeredObject = (NSObject *)object;
            if ([arrayItem.observered isEqual:observeredObject]) { // 数组指针的变化
                arrayItem.observered_property = [observeredObject valueForKeyPath:keyPath];
                if (arrayItem.observered_property) {
                    NSAssert([arrayItem.observered_property isKindOfClass:[NSArray class]], @"make sure [arrayItem.observered_property isKindOfClass:[NSArray class]] be YES");
                }
                void(^detailBlock)(NSString *keyPath, NSDictionary *change, JKKVOArrayChangeModel *changedModel, void *context) = arrayItem.detailBlock;
                if (detailBlock) {
                    [JKKVOItemManager jk_judgeCycleInvokeWithItem:arrayItem block:^{
                        detailBlock(keyPath,change,nil,context);
                    }];
                    
                }
            } else { // 数组元素对应的属性的变化
               void(^detailBlock)(NSString *keyPath, NSDictionary *change, JKKVOArrayChangeModel *changedModel, void *context) = arrayItem.detailBlock;
                if (detailBlock) {
                    NSArray <JKKVOArrayElement *>*kvoElements = [arrayItem kvoElementsWithElement:observeredObject];
                    JKKVOArrayChangeModel *changedModel = [JKKVOArrayChangeModel new];
                    changedModel.changeType = JKKVOArrayChangeTypeElement;
                    changedModel.changedElements = kvoElements;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    if ((arrayItem.options & NSKeyValueObservingOptionOld) == NSKeyValueObservingOptionOld) {
                        dic[NSKeyValueChangeOldKey] = arrayItem.observered_property;
                    }
                    
                    if ((arrayItem.options & NSKeyValueObservingOptionNew) == NSKeyValueObservingOptionNew) {
                        dic[NSKeyValueChangeNewKey] = arrayItem.observered_property;
                    }
                    [JKKVOItemManager jk_judgeCycleInvokeWithItem:arrayItem block:^{
                        detailBlock(arrayItem.keyPath,dic,changedModel,arrayItem.context);
                    }];
                    
                }
            }
            
        } else if ([item isKindOfClass:[JKKVOComputedItem class]]) {
            JKKVOComputedItem *computedItem = (JKKVOComputedItem *)item;
            void(^block)(NSString *keyPath, NSDictionary *change, void *context) = computedItem.block;
            if (block) {
                [JKKVOItemManager jk_judgeCycleInvokeWithItem:computedItem block:^{
                    block(keyPath,change,context);
                }];
                
            }
        } else if ([item isKindOfClass:[JKKVOItem class]]) {
            JKKVOItem *kvoItem = (JKKVOItem *)item;
            void(^block)(NSString *keyPath, NSDictionary *change, void *context) = kvoItem.block;
            if (block) {
                [JKKVOItemManager jk_judgeCycleInvokeWithItem:kvoItem block:^{
                    block(keyPath,change,context);
                }];
            }
        }
        
    }
}

@end
