//
//  JKHitTestButton.h
//  JKUIHelper
//
//  Created by JackLee on 2018/1/6.
//

#import <UIKit/UIKit.h>

@interface JKHitTestButton : UIButton

@property (nonatomic,assign) CGFloat clickExtendX;   ///< 按钮点击事件增加的点击区域的宽度，default 20
@property (nonatomic,assign) CGFloat clickExtendY;   ///< 按钮点击事件增加的点击区域的高度  default 20

@end
