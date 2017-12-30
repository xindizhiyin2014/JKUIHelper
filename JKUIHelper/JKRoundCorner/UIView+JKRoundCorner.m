//
//  UIView+JKRoundCorner.m
//  JKUIHelper
//
//  Created by JackLee on 2017/12/30.
//

#import "UIView+JKRoundCorner.h"

@implementation UIView (JKRoundCorner)

- (void)jkDrawRoundCornerWithCorners:(UIRectCorner)corners radius:(CGFloat)cornerRadius{

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                byRoundingCorners:corners
                                                      cornerRadii: (CGSize){cornerRadius,cornerRadius}].CGPath;
    self.layer.mask = maskLayer;
}

- (void)jkDrawRoundCornerWithRect:(CGRect)rect Corners:(UIRectCorner)corners radius:(CGFloat)cornerRadius{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                           byRoundingCorners:corners
                                                 cornerRadii: (CGSize){cornerRadius,cornerRadius}].CGPath;
    self.layer.mask = maskLayer;
}

@end
