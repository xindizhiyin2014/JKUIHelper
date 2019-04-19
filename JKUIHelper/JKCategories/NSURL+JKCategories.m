//
//  NSURL+JKCategories.m
//  JKUIHelper
//
//  Created by JackLee on 2019/4/19.
//

#import "NSURL+JKCategories.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

@implementation NSURL (JKCategories)

- (UIImage*)jkVideoPreViewImage
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}
@end
