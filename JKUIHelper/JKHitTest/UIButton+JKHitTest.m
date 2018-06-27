//
//  UIButton+JKHitTest.m
//  JKUIHelper
//
//  Created by JackLee on 2018/6/26.
//

#import "UIButton+JKHitTest.h"
#import <objc/runtime.h>

static const char *hitTestInsetsKey = "JKHitTestInsetsKey";
static const char *useHitTestInsetsKey = "JKUseHitTestInsetsKey";
@implementation UIButton (JKHitTest)

- (void)setHitTestInsets:(UIEdgeInsets)hitTestInsets{
    NSValue *value = [NSValue valueWithBytes:&hitTestInsets objCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &useHitTestInsetsKey, @(YES), OBJC_ASSOCIATION_RETAIN);
     objc_setAssociatedObject(self, &hitTestInsetsKey, value, OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)hitTestInsets{
    NSValue *value = objc_getAssociatedObject(self, &hitTestInsetsKey);
    UIEdgeInsets insets;
    [value getValue:&insets];
    return insets;
}

//扩大关闭按钮的点击区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSNumber *useHitTestInsets = objc_getAssociatedObject(self, &useHitTestInsetsKey);
    BOOL status = [useHitTestInsets boolValue];
    if (status) {
        CGRect bounds = self.bounds;
        CGFloat extendX = self.hitTestInsets.left + self.hitTestInsets.right;
        CGFloat extendY = self.hitTestInsets.top + self.hitTestInsets.bottom;
        bounds = CGRectOffset(bounds, self.hitTestInsets.top, self.hitTestInsets.left);
        bounds = CGRectInset(bounds, extendX, extendY);
        return CGRectContainsPoint(bounds, point);
    }
    CGRect bounds = self.bounds;
    return CGRectContainsPoint(bounds, point);
}


@end
