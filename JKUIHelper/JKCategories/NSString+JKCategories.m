//
//  NSString+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/4/19.
//

#import "NSString+JKCategories.h"
#import "NSURL+JKCategories.h"

@implementation NSString (JKCategories)
- (UIImage*)jkVideoPreViewImage{
    NSURL *url = [NSURL URLWithString:self];
    if (!url) {
        return nil;
    }
    return [url jkVideoPreViewImage];
}


@end
