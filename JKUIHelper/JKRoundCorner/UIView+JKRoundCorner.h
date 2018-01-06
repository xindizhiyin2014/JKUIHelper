//
//  UIView+JKRoundCorner.h
//  JKUIHelper
//
//  Created by JackLee on 2017/12/30.
//

#import <UIKit/UIKit.h>

@interface UIView (JKRoundCorner)

//firt you should give set frame of the view
- (void)jkDrawRoundCornerWithCorners:(UIRectCorner)corners radius:(CGFloat)cornerRadius;

- (void)jkDrawRoundCornerWithRect:(CGRect)rect Corners:(UIRectCorner)corners radius:(CGFloat)cornerRadius;

@end
