//
//  XLCardSwitchFlowLayout.m
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "XLCardSwitchFlowLayout.h"

//居中卡片宽度与据屏幕宽度比例
static float CardWidthScale = 1;//0.7f;
static float CardHeightScale = 1;//0.8f;

@implementation XLCardSwitchFlowLayout

//初始化方法
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}

//设置缩放动画
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //扩大控制范围，防止出现闪屏现象
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2*[UIScreen mainScreen].bounds.size.width;
    bigRect.origin.x = rect.origin.x - [UIScreen mainScreen].bounds.size.width;
    
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:bigRect]];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        NSInteger num = (NSInteger)distance/self.collectionView.bounds.size.width;
        apartScale = apartScale -num;

        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * cosf(0.9)));
        scale = scale>0.9?scale:0.9;

        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

#pragma mark -
#pragma mark 配置方法


//卡片间隔
- (float)cellMargin {
    return (self.collectionView.bounds.size.width - [UIScreen mainScreen].bounds.size.width)/7;
}

//设置左右缩进
- (CGFloat)collectionInset {
    return self.collectionView.bounds.size.width/2.0f - [UIScreen mainScreen].bounds.size.width/2.0f;
}

#pragma mark -
#pragma mark 约束设定
//最小纵向间距
- (CGFloat)minimumLineSpacing {
    return 0;
}
//cell大小
- (CGSize)itemSize {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

#pragma mark -
#pragma mark 其他设定
//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

@end
