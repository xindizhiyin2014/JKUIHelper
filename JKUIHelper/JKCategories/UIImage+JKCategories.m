//
//  UIImage+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/4/19.
//

#import "UIImage+JKCategories.h"

@implementation UIImage (JKCategories)
- (UIImage *)jkImgWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size{
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
+ (UIImage *)jkImgWithColor:(UIColor *)color{
    return [self jkImgWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)jkImgWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)jkAppendImg:(UIImage *)img origin:(NSDictionary *)origin{
    if (!img ||!origin) {
        NSAssert(NO, @"function jkAppendImg:origin: param can't be nil ");
    }
    
    return [self jkAppendImgs:@[img] origins:@[origin]];
}

- (UIImage *)jkAppendImgs:(NSArray <UIImage *>*)imgs origins:(NSArray <NSDictionary *>*)origins{
    if (!imgs ||!origins || imgs.count != origins.count) {
        NSAssert(NO, @"function jkAppendImgs:origin: notice param ");
    }
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    for (NSInteger i = 0; i < imgs.count; i++) {
        UIImage *img = [imgs objectAtIndex:i];
        NSDictionary *origin = [origins objectAtIndex:i];
        CGFloat x = [[origin objectForKey:@"x"] floatValue];
        CGFloat y = [[origin objectForKey:@"y"] floatValue];
        [img drawInRect:CGRectMake(x,y,img.size.width,img.size.height)];
    }
    
    CGImageRef newMergeImg = CGImageCreateWithImageInRect(UIGraphicsGetImageFromCurrentImageContext().CGImage,
                                                          CGRectMake(0, 0, self.size.width, self.size.height));
    
    UIGraphicsEndImageContext();
    if (!newMergeImg) {
        return nil;
    }
    
    return [UIImage imageWithCGImage:newMergeImg];
}
@end
