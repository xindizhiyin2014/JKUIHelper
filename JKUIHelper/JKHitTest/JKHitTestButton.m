//
//  JKHitTestButton.m
//  JKUIHelper
//
//  Created by JackLee on 2018/1/6.
//

#import "JKHitTestButton.h"

@implementation JKHitTestButton

- (id)init{
    self = [super init];
    if (self) {
        self.clickExtendX = 20;
        self.clickExtendY = 20;
    }
    return self;
}
//扩大关闭按钮的点击区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, -self.clickExtendX, -self.clickExtendY);
    return CGRectContainsPoint(bounds, point);
}

@end
