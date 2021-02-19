//
//  JKScrollViewHelper.h
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 头部背景视图风格
typedef NS_ENUM(NSUInteger, JKHeaderBackStyle) {
    JKHeaderBackStyleFixed = 0, ///< 默认样式，头部固定大小（不放大）
    JKHeaderBackStyleExpand = 1, ///< 头部放大
};

@interface JKScrollExtraViewConfig : NSObject

/// frontView,backgroundView尺寸大小保持一致

/// 前置视图
@property (nonatomic, weak) __kindof UIView *frontView;
/// 背景视图
@property (nonatomic, weak) __kindof UIView *backgroundView;
/// 滚动视图内容对背景视图的覆盖高度
@property (nonatomic, assign) CGFloat headerOverHeight;
/// 头部视图风格
@property (nonatomic, assign) JKHeaderBackStyle headerStyle;

@end

@interface JKScrollViewHelper : NSObject

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

/// 初始化
/// @param scrollView 滚动视图
/// @param headerConfig 配置对象
+ (JKScrollViewHelper *)initWithScrollView:(UIScrollView *)scrollView
                          headerViewConfig:(JKScrollExtraViewConfig *)headerConfig;

@end
