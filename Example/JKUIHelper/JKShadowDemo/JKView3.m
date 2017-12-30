//
//  JKView3.m
//  JKShadow_Example
//
//  Created by Jack on 2017/11/10.
//  Copyright © 2017年 HHL110120. All rights reserved.
//

#import "JKView3.h"
#import <JKUIHelper/JKShadow.h>

@implementation JKView3


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [[UIColor redColor] set];
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100, 100)];
    [bezierPath addLineToPoint:CGPointMake(180, 150)];
    [bezierPath addLineToPoint:CGPointMake(150, 180)];
    [bezierPath closePath];
    [bezierPath fill];
    [bezierPath stroke];

    [JKShadow drawShadowWithShadowPath:bezierPath.CGPath shadowColor:[UIColor blackColor] offset:CGSizeMake(3, 5) blur:3];
}

@end
