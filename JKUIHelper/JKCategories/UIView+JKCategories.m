//
//  UIView+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/5/2.
//

#import "UIView+JKCategories.h"

@implementation UIView (JKCategories)
- (void)addbgColors:(NSArray <UIColor *>*)colors ratios:(NSArray <NSNumber *>*)ratios direction:(JKDirection)direction{
    CGRect rect = self.bounds;
    [self addbgColors:colors ratios:ratios direction:direction inRect:rect];
    
}

- (void)addbgColors:(NSArray <UIColor *>*)colors ratios:(NSArray <NSNumber *>*)ratios direction:(JKDirection)direction inRect:(CGRect)rect{
    if (colors.count !=ratios.count) {
        NSAssert(NO, @"colos.count is not equal to ratios.count");
    }
    
    CALayer *bgLayer = [CALayer layer];
    bgLayer.frame = rect;
    [self.layer addSublayer:bgLayer];
    __block float totalNum = 0;
    [ratios enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totalNum += [obj floatValue];
    }];
    
    if (totalNum !=1) {
        if (totalNum ==0) {
            NSAssert(NO, @"ratios's all object sum can't be zero");
        }
        NSMutableArray *tempRatios = [NSMutableArray new];
        [ratios enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger ratio = [obj floatValue]/totalNum;
            [tempRatios addObject:@(ratio)];
        }];
        ratios = [tempRatios copy];
    }
    
    CGFloat beforeRatio = 0.0f; //前面的一个颜色的比例
    if (direction == JKDirectionVertical) {
        for (NSInteger i=0; i<ratios.count; i++) {
            UIColor *color = [colors objectAtIndex:i];
            CGFloat ratio = [[ratios objectAtIndex:i] floatValue];
            CGRect layerRect = CGRectMake(rect.origin.x, rect.origin.y + beforeRatio * rect.size.height, rect.size.width, ratio * rect.size.height);
            beforeRatio +=ratio;
            CALayer *subLayer = [CALayer layer];
            subLayer.frame = layerRect;
            subLayer.backgroundColor = color.CGColor;
            [bgLayer addSublayer:subLayer];
        }
    }else{
        for (NSInteger i=0; i<ratios.count; i++) {
            UIColor *color = [colors objectAtIndex:i];
            CGFloat ratio = [[ratios objectAtIndex:i] floatValue];
            CGRect layerRect = CGRectMake(rect.origin.x + beforeRatio * rect.size.width, rect.origin.y, ratio * rect.size.width, rect.size.height);
            beforeRatio +=ratio;
            CALayer *subLayer = [CALayer layer];
            subLayer.frame = layerRect;
            subLayer.backgroundColor = color.CGColor;
            [bgLayer addSublayer:subLayer];
        }
    }
}
@end
