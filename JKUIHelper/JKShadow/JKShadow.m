//
//  JKShadow.m
//  JKShadow
//
//  Created by Jack on 2017/11/7.
//

#import "JKShadow.h"

@implementation JKShadow

+ (void)drawShadowOnView:(UIView *)view shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity{
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = offset;
    view.layer.shadowOpacity = opacity;
    
}

+ (void)drawShadowOnRoundView:(UIView *)view shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = offset;
    view.layer.shadowOpacity = opacity;
    view.layer.shadowPath = shadowPath.CGPath;
}

+ (void)drawShadowOnView:(UIView *)view cornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRadius];
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = offset;
    view.layer.shadowOpacity = opacity;
    view.layer.shadowPath = shadowPath.CGPath;
}

+ (void)drawShadowWithShadowPath:(CGPathRef)shadowPath shadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetShadowWithColor(currentContext,offset, blur,color.CGColor);
    
    CGContextAddPath(currentContext, shadowPath);
    CGContextDrawPath(currentContext, kCGPathFill);
    
    
}

@end
