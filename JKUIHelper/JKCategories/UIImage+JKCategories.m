//
//  UIImage+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/4/19.
//

#import "UIImage+JKCategories.h"

@implementation UIImage (JKCategories)
- (UIImage *)imageWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size{
    /* 当前UIImage的可见绘制区域 */
    CGRect rect = (CGRect){0.f,0.f,size};
    /* 创建基于位图的上下文 */
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    /* 在当前位图上下文添加圆角绘制路径 */
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    /* 当前绘制路径和原绘制路径相交得到最终裁剪绘制路径 */
    CGContextClip(UIGraphicsGetCurrentContext());
    /* 绘制 */
    [self drawInRect:rect];
    /* 取得裁剪后的image */
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    /* 关闭当前位图上下文 */
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  根据颜色返回图片
 *
 *  @param color 传入的颜色
 *
 *  @return 返回的image
 */
+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
