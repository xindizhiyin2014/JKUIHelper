//
//  UIImageView+JKCategories.h
//  JKUIHelper
//
//  Created by JackLee on 2019/5/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (JKCategories)
- (void)jkSetImageWithURL:(nullable NSURL *)url size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
- (void)jkSetImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
@end

NS_ASSUME_NONNULL_END
