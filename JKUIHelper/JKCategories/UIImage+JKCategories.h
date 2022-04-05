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
/**
 *  根据颜色返回图片
 *
 *  @param color 传入的颜色
 *  @param size 图片的尺寸
 *
 *  @return 返回的image
 */
+ (UIImage *)jkImgWithColor:(UIColor *)color size:(CGSize)size;

/**
 根据颜色返回图片

 @param color 传入的颜色
 @param size 图片的尺寸
 @param radius 圆角
 @return 返回的image
 */
+ (UIImage *)jkImgWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius;
/**
 图片合成

 @param img 需要合成到主图上的图片
 @param origin 图片初始位置格式：@{@"x":@"",@"y":@""}
 @return 合成后的图片
 */
- (UIImage *)jkAppendImg:(UIImage *)img origin:(NSDictionary *)origin;

/**
 图片合成

 @param imgs 需要合成到主图上的图片数组
 @param origins 图片初始位置数组，图片初始位置格式：@{@"x":@"",@"y":@""}
 @return 合成后的图片
 */
- (UIImage *)jkAppendImgs:(NSArray <UIImage *>*)imgs origins:(NSArray <NSDictionary *>*)origins;

/**
 图片合成

 @param size 最后生成图片的尺寸
 @param imgs 需要被合成的图片的数组
 @param origins 需要被合成的图片初始位置数组，图片初始位置格式：@{@"x":@"",@"y":@""}
 @return 合成后的图片
 */
+ (UIImage *)jkMergeImgsAtSize:(CGSize)size imgs:(NSArray <UIImage *>*)imgs origins:(NSArray <NSDictionary *>*)origins;

/**
 图片修改透明度

 @param alpha 透明度值
 @return 修改透明度后的图片
 */
- (UIImage *)jkImgWithAlpha:(CGFloat)alpha;

/// 根据视图生成图片,view的frame必须已经确定
/// @param view 目标视图
+ (nullable UIImage *)jkImgOfView:(UIView *)view;

/// 根据视图生成图片,view的frame必须已经确定
/// @param view 目标视图
/// @param scale 屏幕的scale
+ (nullable UIImage *)jkImgOfView:(UIView *)view screenScale:(CGFloat)scale;

/// 将UIImage对象保存到沙盒路径
/// @param path 图片文件的路径,带图片名字的
- (BOOL)saveToPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
