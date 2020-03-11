//
//  UIColor+JKCategories.h
//  JKUIHelper
//
//  Created by JackLee on 2019/7/11.
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JKCategories)
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式

+ (UIColor *)jkColorWithHexString:(NSString *)hexString;

+ (UIColor *)jkColorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;


/**
 根据UIColor色值获取hexString值
  @return hexString
 */
- (NSString *)jkHexString;

/// 根据light,dark获取对应的颜色，light在前，dark在后，中间用','分割
/// 示例如下：@“#aaaaaa,#bbbbbb”
/// @param string 颜色16进制字符串，包含两种模式
+ (UIColor *)jkThemeColorWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
