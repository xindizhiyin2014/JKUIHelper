//
//  JKCollectionViewCell.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2020/11/12.
//  Copyright © 2020 xindizhiyin2014. All rights reserved.
//

#import "JKCollectionViewCell.h"

@implementation JKCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    NSLog(@"tap::indexPath:%@",@(self.indexPath.item));
}

@end
