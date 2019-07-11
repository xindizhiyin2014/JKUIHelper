//
//  NSString+JKCategories.h
//  JKUIHelper
//
//  Created by JackLee on 2019/4/19.
//

#import <Foundation/Foundation.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JKCategories)
/**
 get the video preview image
 
 @return image
 */
- (UIImage*)jkVideoPreViewImage;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式

+ (UIColor *)jkColorWithHexString:(NSString *)color;

+ (UIColor *)jkColorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 根据UIColor色值获取hexString值
 
 @param color UIColor值
 @return hexString
 */
+ (NSString *)jkHexFromUIColor:(UIColor*) color;

@end

NS_ASSUME_NONNULL_END
