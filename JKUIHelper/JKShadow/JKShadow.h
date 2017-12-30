//
//  JKShadow.h
//  JKShadow
//
//  Created by Jack on 2017/11/7.
//

#import <Foundation/Foundation.h>

@interface JKShadow : NSObject

/**
 给UIView添加阴影

 @param view 添加阴影的视图
 @param color 阴影的颜色
 @param offset 阴影的偏移量
 @param opacity 透明度
 */
+ (void)drawShadowOnView:(UIView *)view shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity;

/**
 给圆形的UIView添加阴影

 @param view 添加阴影的圆形视图
 @param color 阴影的颜色
 @param offset 阴影的偏移量
 @param opacity 透明度
 */
+ (void)drawShadowOnRoundView:(UIView *)view shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity;


/**
 给带圆角的UIView添加阴影

 @param view 添加阴影的圆角视图
 @param cornerRadius 圆角半径
 @param color 阴影的颜色
 @param offset 阴影的偏移量
 @param opacity 透明度
 */
+ (void)drawShadowOnView:(UIView *)view cornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity;



/**
 给自定义的路径，添加阴影

 @param shadowPath 阴影的路径
 @param color 阴影的颜色
 @param offset 阴影的偏移量   阴影的位移,由 CGSize 类型值指定,从每个形状要应用阴影的右下部分开始。位移的 x 值越大,形状右边的阴影就扩散得越远。位移的 y 值越大,下部的阴影就越低。
 @param blur 阴影的模糊值,以浮点值(CGFloat)来指定。指定 0.0f 将导致阴影成为固态形状。这个值越高,阴影就越 
 */
+ (void)drawShadowWithShadowPath:(CGPathRef)shadowPath shadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;
@end
