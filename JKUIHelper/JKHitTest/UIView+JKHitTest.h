//
//  UIView+JKHitTest.h
//  JKUIHelper
//
//  Created by JackLee on 2018/6/4.
//

#import <UIKit/UIKit.h>

@interface UIView (JKHitTest)
@property (nonatomic,weak) UIView *jkRealRespondView;    ///< 真正响应的视图
@end
