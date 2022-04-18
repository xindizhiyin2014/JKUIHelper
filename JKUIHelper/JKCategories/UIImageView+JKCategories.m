//
//  UIImageView+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/5/2.
//

#import "UIImageView+JKCategories.h"
#import "UIImage+JKCategories.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import <objc/runtime.h>

@implementation UIImageView (JKCategories)

- (NSMutableDictionary *)jk_OperationDictionary
{
    return objc_getAssociatedObject(self, @selector(jk_OperationDictionary));
}


- (void)setJk_OperationDictionary:(NSMutableDictionary *)jk_OperationDictionary {
    objc_setAssociatedObject(self, @selector(jk_OperationDictionary), jk_OperationDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)jk_image:(UIImage *)image
          radius:(CGFloat)radius
          ofSize:(CGSize)size
{
    /* 当前UIImage的可见绘制区域 */
    CGRect rect = (CGRect){0.f,0.f,size};
    /* 创建基于位图的上下文 */
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    /* 在当前位图上下文添加圆角绘制路径 */
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    /* 当前绘制路径和原绘制路径相交得到最终裁剪绘制路径 */
    CGContextClip(UIGraphicsGetCurrentContext());
    /* 绘制 */
    [image drawInRect:rect];
    /* 取得裁剪后的image */
    UIImage *targetImg = UIGraphicsGetImageFromCurrentImageContext();
    /* 关闭当前位图上下文 */
    UIGraphicsEndImageContext();
    self.image = targetImg;
}

- (void)jk_imageWithUrl:(nullable NSString *)url
                 radius:(CGFloat)radius
                 ofSize:(CGSize)size
{
    [self jk_imageWithUrl:url radius:radius ofSize:size placeholderImage:nil];
}

/// 加载url，并对image设置圆角
/// @param url 图片的url
/// @param radius 圆角半径
/// @param size 视图的size
/// @param placeholderImage 缺省图
- (void)jk_imageWithUrl:(nullable NSString *)url
                 radius:(CGFloat)radius
                 ofSize:(CGSize)size
       placeholderImage:(nullable UIImage *)placeholderImage
{
    
    if (!self.jk_OperationDictionary) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        self.jk_OperationDictionary = dic;
    }
    NSString *key = NSStringFromClass([self class]);
    if (url) {
        NSURL *currentURL = [NSURL URLWithString:url];
        NSString *imageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:currentURL];
        UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:imageKey];
        if (cachedImage) {//直接返回，不再执行后续逻辑
            [self jk_image:cachedImage radius:radius ofSize:size];
            return;
        }
        @synchronized (self) {
//            存储即将下载的url
            self.jk_OperationDictionary[key] = currentURL;
        }
        [self jk_image:placeholderImage radius:radius ofSize:size];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:currentURL completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                NSURL *storedURL = self.jk_OperationDictionary[key];
                NSString *imageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:currentURL];
                [[SDImageCache sharedImageCache] storeImage:image forKey:imageKey completion:nil];
                if ([storedURL.absoluteString isEqualToString:currentURL.absoluteString]) {
                    //url和下载的时候相匹配了才进行展示
                    [self jk_image:image radius:radius ofSize:size];
                    self.jk_OperationDictionary[key] = nil;
                }
            } else {
                [self jk_image:placeholderImage radius:radius ofSize:size];
            }
        }];
        
    } else {
        [self jk_image:placeholderImage radius:radius ofSize:size];
    }
}
@end
