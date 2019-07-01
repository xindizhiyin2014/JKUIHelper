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


- (void)jkHorizontalCenterImageAndTitleWithSpacing:(CGFloat)spacing
{
    // left the image
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -spacing, 0.0, 0.0);
    
    // right the text
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -spacing);
}

/**
 *  水平居中按钮 title 和 image
 *
 *  @param spacing - image 和 title 的水平间距, 单位point
 */
- (void)jkHorizontalCenterTitleAndImageWithSpacing:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleLabel.font} context:nil].size;
    
    // get the width they will take up as a unit
    CGFloat totalWidth = (imageSize.width + titleSize.width + spacing);
    
    // right the image
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -(totalWidth - imageSize.width) * 2);
    
    // left the text
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(totalWidth - titleSize.width) * 2, 0.0, 0.0);
}

/**
 *  垂直居中按钮 image 和 title
 *
 *  @param spacing - image 和 title 的垂直间距, 单位point
 */
- (void)jkVerticalCenterImageAndTitleWithSpacing:(CGFloat)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    //    CGSize titleSize = self.titleLabel.frame.size;
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleLabel.font} context:nil].size;
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(totalHeight - titleSize.height), 0.0);
}

@end
