//
//  UIColor+JKCategoriesSpec.m
//  JKUIHelper
//
//  Created by JackLee on 2020/3/11.
//  Copyright 2020 xindizhiyin2014. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "UIColor+JKCategories.h"


SPEC_BEGIN(UIColor_JKCategoriesSpec)

describe(@"UIColor+JKCategories", ^{
         context(@"jkThemeColorWithString:", ^{
             it(@"string is nil", ^{
                 [[theBlock(^{
                     UIColor *color = [UIColor jkThemeColorWithString:nil];
                 }) should]raiseWithReason:@"string can not be nil"];
             });
             it(@"string not contain ','", ^{
                 NSString *string = @"#aaaaaaa";
                 UIColor *color = [UIColor jkThemeColorWithString:string];
                 [[color shouldNot] beNil];
                 [[theValue([[color jkHexString] hasSuffix:@"aaaaaa"]) should] beYes];
             });
             it(@"string contain ',', but only has first color", ^{
                 NSString *string = @"#aaaaaaa,";
                 UIColor *color = [UIColor jkThemeColorWithString:string];
                 [[color shouldNot] beNil];
                 [[theValue([[color jkHexString] hasSuffix:@"aaaaaa"]) should] beYes];
             });
             it(@"string contain ',', but only has last color", ^{
                 NSString *string = @",#aaaaaa";
                 [[theBlock(^{
                     [UIColor jkThemeColorWithString:string];
                 }) should] raiseWithReason:@"make sure first_hex.length > 0 be YES"];
             });
             it(@"string contain two color", ^{
                 NSString *string = @"#aaaaaa,#111111";
                 UIColor *color = [UIColor jkThemeColorWithString:string];
                 [[theValue([[color jkHexString] hasSuffix:@"111111"]) should] beYes];
             });
             
         });
});

SPEC_END
