//
//  JKScrollHelper.h
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import <Foundation/Foundation.h>

@interface JKScrollHelperView:UIView

@end;

@interface JKScrollHelperImgView:UIImageView

@end;

typedef NS_ENUM(NSInteger,JKScrollStyle) {
 JKScrollStyleHeaderNormal = 0,      ///< 头视图不放大
 JKScrollStyleHeaderScale,           ///< 头视图随着向下划动放大
 JKScrollStyleHeaderScaleWithSystem, ///< 头视图随着向下划动放大,并且和系统头视图形成层叠关系
 JKScrollStyleHeaderNormalWithSection ///< 头视图不放大，并且和sectionHeader形成层叠关系
};
@interface JKScrollHelper : NSObject

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;


/**
 初始化方法

 @param scrollView 滚动视图
 @param headerView 头视图 JKScrollHelperView,JKScrollHelperImgView类型
 @param style 风格
 @return helper对象
 */
+ (instancetype)initWithScrollView:(UIScrollView *)scrollView headerView:(id)headerView style:(JKScrollStyle)style;
/**
 滚动时透视图执行相关的放大操作

 @param scrollView 滚动视图
 @param insetHeight scrollView距离父视图顶部的缩进
 */
- (void)scrollViewDidSroll:(UIScrollView *)scrollView superViewInsetHeight:(CGFloat)insetHeight;
- (void)scrollViewDidSroll:(UIScrollView *)scrollView offsetY:(CGFloat)offsetY superViewInsetHeight:(CGFloat)insetHeight;

/**
 初始化方法

 @param scrollView 滚动视图
 @param footerView  JKScrollHelperView,JKScrollHelperImgView类型
 @return helper对象
 */

+ (instancetype)initWithScrollView:(UIScrollView *)scrollView footerView:(id)footerView;

/**
 添加footer

 @param footerView JKScrollHelperView,JKScrollHelperImgView类型
 */
- (void)addFooterView:(id)footerView;

@end
