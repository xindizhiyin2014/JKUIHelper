//
//  UIImageView+JKCategories.h
//  JKUIHelper
//
//  Created by JackLee on 2019/5/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (JKCategories)

//用来保存当前正在下载的url，cell重用的时候会用到
@property (nonatomic, copy, readonly, nullable) NSMutableDictionary <NSString *,NSURL *>*jk_OperationDictionary;

/// 设置图片，并对图片进行圆角操作（不是对视图设置圆角）
/// @param image image
/// @param radius 圆角半径
/// @param size 视图的size
- (void)jk_image:(UIImage *)image
          radius:(CGFloat)radius
          ofSize:(CGSize)size;

/// 加载url，并对image设置圆角
/// @param url 图片的url
/// @param radius 圆角半径
/// @param size 视图的size
- (void)jk_imageWithUrl:(nullable NSString *)url
                 radius:(CGFloat)radius
                 ofSize:(CGSize)size;

/// 加载url，并对image设置圆角
/// @param url 图片的url
/// @param radius 圆角半径
/// @param size 视图的size
/// @param placeholderImage 缺省图
- (void)jk_imageWithUrl:(nullable NSString *)url
                 radius:(CGFloat)radius
                 ofSize:(CGSize)size
       placeholderImage:(nullable UIImage *)placeholderImage;
@end

NS_ASSUME_NONNULL_END
