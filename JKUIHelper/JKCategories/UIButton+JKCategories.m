//
//  UIButton+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/5/3.
//

#import "UIButton+JKCategories.h"
#import "UIImage+JKCategories.h"
#import <SDWebImage/SDWebImageDownloader.h>
@implementation UIButton (JKCategories)
- (void)jkSetImgWithURL:(NSURL *)url size:(CGSize)size cornerRadius:(CGFloat)cornerRadius state:(UIControlState)state{
    [self jkSetImgWithURL:url size:size cornerRadius:cornerRadius placeholderImg:nil state:state];
}
- (void)jkSetImgWithURL:(NSURL *)url size:(CGSize)size cornerRadius:(CGFloat)cornerRadius placeholderImg:(nullable UIImage *)placeholder state:(UIControlState)state{
    if (cornerRadius < 0) {
        cornerRadius = 0;
    }
    [self setImage:placeholder forState:state];
    __weak __typeof__(self) weakSelf = self;
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        UIImage *roundImg = [image jkImgWithCornerRadius:cornerRadius ofSize:size];
        __strong __typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setImage:roundImg forState:state];
        }
        
    }];
}
@end
