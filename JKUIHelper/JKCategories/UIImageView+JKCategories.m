//
//  UIImageView+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/5/2.
//

#import "UIImageView+JKCategories.h"
#import "UIImage+JKCategories.h"
#import <SDWebImage/SDWebImageDownloader.h>

@implementation UIImageView (JKCategories)
- (void)jkSetImageWithURL:(nullable NSURL *)url size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
    [self jkSetImageWithURL:url placeholderImage:nil size:size cornerRadius:cornerRadius];
}

- (void)jkSetImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
    if (cornerRadius < 0) {
        cornerRadius = 0;
    }
    self.image = placeholder;
    __weak __typeof__(self) weakSelf = self;
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        UIImage *roundImg = [image jkImgWithCornerRadius:cornerRadius ofSize:size];
        __strong __typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.image = roundImg;
        }
        
    }];
}
@end
