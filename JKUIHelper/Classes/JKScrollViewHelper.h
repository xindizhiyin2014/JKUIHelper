//
//  JKScrollViewHelper.h
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,JKScrollStyle) {
 JKScrollStyleHeaderNormal = 0,
 JKScrollStyleHeaderScale,
 JKScrollStyleHeaderScaleWithSystem,
};
@interface JKScrollViewHelper : NSObject

/**
 初始化方法

 @param scrollView 滚动视图
 @param headerView 头视图
 @param style 风格
 @return helper对象
 */
- (id)initWithScrollView:(UIScrollView *)scrollView headerView:(UIView *)headerView style:(JKScrollStyle)style;
/**
 滚动时透视图执行相关的放大操作

 @param scrollView 滚动视图
 @param insetHeight scrollView距离父视图顶部的缩进
 */
- (void)scrollViewDidSroll:(UIScrollView *)scrollView superViewInsetHeight:(CGFloat)insetHeight;

@end
