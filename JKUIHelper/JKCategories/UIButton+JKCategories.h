//
//  UIButton+JKCategories.h
//  JKUIHelper
//
//  Created by JackLee on 2019/5/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JKCategories)
- (void)jkSetImgWithURL:(NSURL *)url size:(CGSize)size cornerRadius:(CGFloat)cornerRadius state:(UIControlState)state;
- (void)jkSetImgWithURL:(NSURL *)url size:(CGSize)size cornerRadius:(CGFloat)cornerRadius placeholderImg:(nullable UIImage *)placeholder state:(UIControlState)state;
@end

NS_ASSUME_NONNULL_END
