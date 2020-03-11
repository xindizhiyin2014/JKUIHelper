//
//  UIColor+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/7/11.
//

#import "UIColor+JKCategories.h"

@implementation NSString (TDLeftPadding)

// taken from http://stackoverflow.com/questions/964322/padding-string-to-left-with-objective-c

- (NSString *)stringByPaddingTheLeftToLength:(NSUInteger) newLength
                                  withString:(NSString *) padString
                             startingAtIndex:(NSUInteger) padIndex
{
    if ([self length] <= newLength)
        return [[@"" stringByPaddingToLength:newLength - [self length] withString:padString startingAtIndex:padIndex] stringByAppendingString:self];
    else
        return [self copy];
}

@end

@implementation UIColor (JKCategories)
+ (UIColor *)jkColorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if (hexString.length == 0)
        return [UIColor blackColor];
    
    if ([hexString characterAtIndex:0] == '#')
        hexString = [hexString substringFromIndex:1];
    
    NSString *a, *r, *g, *b;
    
    NSUInteger len = hexString.length;
    if (len == 6) {
    six:
        a = @"FF";
        r = [hexString substringWithRange:NSMakeRange(0, 2)];
        g = [hexString substringWithRange:NSMakeRange(2, 2)];
        b = [hexString substringWithRange:NSMakeRange(4, 2)];
    }
    else if (len == 8) {
    eight:
        a = [hexString substringWithRange:NSMakeRange(0, 2)];
        r = [hexString substringWithRange:NSMakeRange(2, 2)];
        g = [hexString substringWithRange:NSMakeRange(4, 2)];
        b = [hexString substringWithRange:NSMakeRange(6, 2)];
    }
    else if (len == 3) {
    three:
        a = @"FF";
        r = [hexString substringWithRange:NSMakeRange(0, 1)];
        r = [r stringByAppendingString:a];
        g = [hexString substringWithRange:NSMakeRange(1, 1)];
        g = [g stringByAppendingString:a];
        b = [hexString substringWithRange:NSMakeRange(2, 1)];
        b = [b stringByAppendingString:a];
    }
    else if (len == 4) {
        a = [hexString substringWithRange:NSMakeRange(0, 1)];
        a = [a stringByAppendingString:a];
        r = [hexString substringWithRange:NSMakeRange(1, 1)];
        r = [r stringByAppendingString:a];
        g = [hexString substringWithRange:NSMakeRange(2, 1)];
        g = [g stringByAppendingString:a];
        b = [hexString substringWithRange:NSMakeRange(3, 1)];
        b = [b stringByAppendingString:a];
    }
    else if (len == 5 || len == 7) {
        hexString = [@"0" stringByAppendingString:hexString];
        if (len == 5) goto six;
        goto eight;
    }
    else if (len < 3) {
        hexString = [hexString stringByPaddingTheLeftToLength:3 withString:@"0" startingAtIndex:0];
        goto three;
    }
    else if (len > 8) {
        hexString = [hexString substringFromIndex:len-8];
        goto eight;
    }
    else {
        a = @"FF";
        r = @"00";
        g = @"00";
        b = @"00";
    }
    
    // parse each component separately. This gives more accurate results than
    // throwing it all together in one string and use scanf on the global string.
    a = [@"0x" stringByAppendingString:a];
    r = [@"0x" stringByAppendingString:r];
    g = [@"0x" stringByAppendingString:g];
    b = [@"0x" stringByAppendingString:b];
    
    uint rv, gv, bv;
    sscanf([r cStringUsingEncoding:NSASCIIStringEncoding], "%x", &rv);
    sscanf([g cStringUsingEncoding:NSASCIIStringEncoding], "%x", &gv);
    sscanf([b cStringUsingEncoding:NSASCIIStringEncoding], "%x", &bv);
    
    return [UIColor colorWithRed: rv / 255.f
                           green: gv / 255.f
                            blue: bv / 255.f
                           alpha: alpha];
}

//默认alpha值为1
+ (UIColor *)jkColorWithHexString:(NSString *)color
{
    return [self jkColorWithHexString:color alpha:1.0f];
}


- (NSString *)jkHexString
{
    uint hex = (uint)[self hex];
    if ((hex & 0xFF000000) == 0xFF000000) {
        return [NSString stringWithFormat:@"#%06x", hex & 0xFFFFFF];
    }
    return [NSString stringWithFormat:@"#%08x", hex];
}

+ (UIColor *)jkThemeColorWithString:(NSString *)string
{
    UIColor *color = nil;
        if (!string) {
    #if DEBUG
            NSAssert(NO, @"string can not be nil");
    #endif
            return color;
        }
        
        if (![string containsString:@","]) {
            color = [self jkColorWithHexString:string];
            return color;
        }
        NSArray *array = [string componentsSeparatedByString:@","];
        NSString *first_hex = array.firstObject;
        NSString *last_hex = array.lastObject;
    #if DEBUG
        NSAssert(first_hex.length > 0, @"make sure first_hex.length > 0 be YES");
    #endif
        if (last_hex.length == 0) {
            color = [self jkColorWithHexString:first_hex];
            return color;
        }
        if (@available(iOS 13.0, *)) {
            color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                //返回暗黑模式下的颜色
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return [self jkColorWithHexString:array.lastObject];
                } else { //返回非暗黑模式下的颜色
                    return [self jkColorWithHexString:array.firstObject];
                }
            }];
        } else {
            color = [self jkColorWithHexString:array.firstObject];
        }
        return color;
}

#pragma mark - - private - -
- (NSUInteger)hex
{
    CGFloat red, green, blue, alpha;
    if (![self getRed:&red green:&green blue:&blue alpha:&alpha]) {
        [self getWhite:&red alpha:&alpha];
        green = red;
        blue = red;
    }
    
    red = roundf(red * 255.f);
    green = roundf(green * 255.f);
    blue = roundf(blue * 255.f);
    alpha = roundf(alpha * 255.f);
    
    return ((uint)alpha << 24) | ((uint)red << 16) | ((uint)green << 8) | ((uint)blue);
}

@end
