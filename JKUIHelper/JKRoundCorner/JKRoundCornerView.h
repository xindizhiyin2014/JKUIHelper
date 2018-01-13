//
//  JKRoundCornerView.h
//  JKUIHelper
//
//  Created by JackLee on 2017/12/30.
//

#import <UIKit/UIKit.h>

//notice:use this class firt you should  set  a frame of the view,then the corner will work normal
@interface JKRoundCornerView : UIView

@property (nonatomic, assign) CGFloat jkCornerRadius; ///< 圆角半径

@property (nonatomic, assign) UIRectCorner jkCorners; ///< 圆角类型。分别为左上，左下，右上，右下

@end
