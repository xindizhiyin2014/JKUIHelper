//
//  JKScrollViewHelper.m
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#import "JKScrollViewHelper.h"
#import <JKKVOHelper/JKKVOHelper.h>

@implementation JKScrollExtraViewConfig

@end

@interface JKScrollViewHelper()

///滚动视图
@property (nonatomic, weak) UIScrollView *scrollView;
///顶部inset
@property (nonatomic, assign) CGFloat contentInsetTop;
///底部inset
@property (nonatomic, assign) CGFloat contentInsetBottom;
///配置实例
@property (nonatomic, strong) JKScrollExtraViewConfig *extraHeaderViewConfig;

@end

@implementation JKScrollViewHelper

+ (JKScrollViewHelper *)initWithScrollView:(UIScrollView *)scrollView
                          headerViewConfig:(JKScrollExtraViewConfig *)headerConfig
{
    JKScrollViewHelper *scrollViewHelper = [[self alloc] init];
    if(scrollViewHelper){
        CGRect frame = CGRectZero;
        if (!headerConfig.backgroundView
            && !headerConfig.frontView) {
            NSAssert(NO, @"frontView and backgroundView can't be nil at same time!");
        }
        if (!headerConfig.frontView) {
            headerConfig.backgroundView.clipsToBounds = YES;
            frame = headerConfig.backgroundView.frame;
        } else {
            headerConfig.frontView.clipsToBounds = YES;
            frame = headerConfig.frontView.frame;
        }
        
        if (!headerConfig.backgroundView) {
            headerConfig.frontView.clipsToBounds = YES;
            frame = headerConfig.frontView.frame;
        }
        scrollViewHelper.extraHeaderViewConfig = headerConfig;
        
        CGPoint origin = frame.origin;
        ///y原点 = 背景视图的原高度 - inset高度
        CGFloat contentInsetTop = CGRectGetHeight(frame) - headerConfig.headerOverHeight;
        origin.y = - contentInsetTop;
        frame.origin = origin;
        if (headerConfig.frontView) {
            headerConfig.frontView.frame = frame;
            [scrollView addSubview:headerConfig.frontView];
        }
        if (headerConfig.backgroundView) {
            headerConfig.backgroundView.frame = frame;
            [scrollView addSubview:headerConfig.backgroundView];
        }
        scrollViewHelper.scrollView = scrollView;
        
        scrollViewHelper.contentInsetTop = contentInsetTop;
        scrollViewHelper.contentInsetBottom = 0;
        scrollView.contentInset = UIEdgeInsetsMake(scrollViewHelper.contentInsetTop, 0, scrollViewHelper.contentInsetBottom, 0);
        [scrollView setContentOffset:CGPointMake(0, -scrollViewHelper.contentInsetTop) animated:NO];
        scrollView.bouncesZoom = NO;
//        if (headerConfig.backgroundView) {
//            [scrollView addSubview:headerConfig.backgroundView];
//        }
//        if (headerConfig.frontView) {
//            [scrollView addSubview:headerConfig.frontView];
//        }
        
        @weakify(scrollView);
        [scrollView jk_addObserver:scrollViewHelper
                        forKeyPath:@"contentOffset"
                           options:NSKeyValueObservingOptionNew
                         withBlock:^(NSDictionary * _Nonnull change,
                                     void * _Nonnull context) {
            @strongify(scrollView);
            [scrollViewHelper scrollViewDidSroll:scrollView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                         (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (headerConfig.backgroundView) {
                    ///将背景视图插到最底层
                    [scrollView insertSubview:headerConfig.backgroundView atIndex:0];
                }
               
                if (headerConfig.frontView) {
                    ///将顶部内容视图插到第二底层,防止覆盖cell,导致cell不能点击
                    [scrollView insertSubview:headerConfig.frontView atIndex:1];
                }
                                      
            });
        }];

    }
    return scrollViewHelper;
}

- (void)scrollViewDidSroll:(UIScrollView *)scrollView
{
    if (self.extraHeaderViewConfig) {
        CGRect frame = CGRectZero;
        if (self.extraHeaderViewConfig.frontView) {
            frame = self.extraHeaderViewConfig.frontView.frame;
        } else {
            frame = self.extraHeaderViewConfig.backgroundView.frame;
        }
        
        CGPoint origin = frame.origin;
        CGSize size = frame.size;
        ///上拉，头部没有放大的时候，放大视图y原点 = 背景视图的原高度 - inset高度
        origin.y = - self.contentInsetTop;
        ///  放大视图的高度等于放大视图的原始高度
        size.height = CGRectGetHeight(frame);
        ///下拉,
        BOOL downPull = !(scrollView.contentOffset.y > - self.contentInsetTop);
        ///放大
        BOOL expand = self.extraHeaderViewConfig.headerStyle == JKHeaderBackStyleExpand;
        if (downPull && expand) {
            ///如果需要放大，需要改变Y原点和视图高度
            ///下拉放大的时候，放大视图y原点 就是 scrollView的偏移量 （负值）
            origin.y = scrollView.contentOffset.y;
            ///  放大视图的高度 = 偏移量的绝对值 + inset高度
            size.height = - scrollView.contentOffset.y + self.extraHeaderViewConfig.headerOverHeight;
        }
        frame.origin = origin;
        frame.size = size;
        self.extraHeaderViewConfig.backgroundView.frame = frame;
    }
}

@end
