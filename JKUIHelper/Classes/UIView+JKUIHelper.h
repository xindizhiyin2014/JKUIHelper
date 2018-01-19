//
//  UIView+JKUIHelper.h
//  JKUIHelper
//
//  Created by JackLee on 2018/1/19.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,JKDirection) {
    JKDirectionVertical,                   ///< 垂直的
    JKDirectionHorizontal                  ///< 水平的
};

@interface UIView (JKUIHelper)
/**
 给视图添加不同的背景颜色 此时需要view已经有frame
 
 @param colors 颜色数组
 @param ratios 各个颜色的比例的分组取
 @param direction 颜色分布的方向
 */
- (void)addbgColors:(NSArray <UIColor *>*)colors ratios:(NSArray <NSNumber *>*)ratios direction:(JKDirection)direction;

/**
 给视图添加不同的背景颜色 此时需要在指定的rect上进行处理
 
 @param colors 颜色数组
 @param ratios 各个颜色的比例的数组 取值范围 0～1 总和等必需于1
 @param direction 颜色分布的方向
 */
- (void)addbgColors:(NSArray <UIColor *>*)colors ratios:(NSArray <NSNumber *>*)ratios direction:(JKDirection)direction inRect:(CGRect)rect;
@end
