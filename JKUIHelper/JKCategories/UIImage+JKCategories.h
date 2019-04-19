//
//  UIImage+JKCategories.h
//  JKUIHelper
//
//  Created by JackLee on 2019/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JKCategories)
/**
 On-screen-renderring绘制UIImage矩形圆角  防止离屏渲染，提高性能
 
 @param radius 圆角半径
 @param size 图片尺寸
 @return 圆角处理后的UIImage对象
 */
- (UIImage *)jkImgWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size;

/**
 *  根据颜色返回图片
 *
 *  @param color 传入的颜色
 *
 *  @return 返回的image
 */
+ (UIImage *)jkImgWithColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
