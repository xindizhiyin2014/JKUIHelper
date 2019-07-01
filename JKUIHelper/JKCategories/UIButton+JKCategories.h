//
//  UIButton+JKCategories.h
//  JKUIHelper
//
//  Created by JackLee on 2019/5/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JKCategories)
- (void)jkSetImgWithURL:(NSURL *)url size:(CGSize)size cornerRadius:(CGFloat)cornerRadius state:(UIControlState)state;
- (void)jkSetImgWithURL:(NSURL *)url size:(CGSize)size cornerRadius:(CGFloat)cornerRadius placeholderImg:(nullable UIImage *)placeholder state:(UIControlState)state;


/**
 *  水平居中按钮 image 和 title
 *
 *  @param spacing - image 和 title 的水平间距, 单位point
 */
- (void)jkHorizontalCenterImageAndTitleWithSpacing:(CGFloat)spacing;

/**
 *  水平居中按钮 title 和 image
 *
 *  @param spacing - image 和 title 的水平间距, 单位point
 */
- (void)jkHorizontalCenterTitleAndImageWithSpacing:(CGFloat)spacing;

/**
 *  垂直居中按钮 image 和 title
 *
 *  @param spacing - image 和 title 的垂直间距, 单位point
 */
- (void)jkVerticalCenterImageAndTitleWithSpacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
