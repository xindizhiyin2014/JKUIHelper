//
//  UIColor+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/7/11.
//

#import "UIColor+JKCategories.h"

@implementation UIColor (JKCategories)
+ (UIColor *)jkColorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)jkColorWithHexString:(NSString *)color
{
    return [self jkColorWithHexString:color alpha:1.0f];
}


+ (NSString *)jkHexFromUIColor: (UIColor*) color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    
    NSString *hexString1 = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1lx",(long)((CGColorGetComponents(color.CGColor))[0]*255.0)]];
    NSString *hexString2 = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1lx",(long)((CGColorGetComponents(color.CGColor))[1]*255.0)]];
    NSString *hexString3 = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1lx",(long)((CGColorGetComponents(color.CGColor))[2]*255.0)]];
    
    return [NSString stringWithFormat:@"#%@%@%@", hexString1,hexString2,hexString3];
}
@end
