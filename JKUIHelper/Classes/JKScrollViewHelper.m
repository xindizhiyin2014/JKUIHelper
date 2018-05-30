//
//  JKScrollViewHelper.m
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import "JKScrollViewHelper.h"
@interface JKScrollViewHelper()
@property (nonatomic,assign)CGSize defautHeaderSize;
@property (nonatomic,weak) UIView *headerView;
@end
@implementation JKScrollViewHelper
- (id)initWithScrollView:(UIScrollView *)scrollView headerView:(UIView *)headerView{
    self = [super init];
    if(self){
        [scrollView addSubview:headerView];
        CGRect frame = headerView.frame;
        frame.origin.y = -frame.size.height;
        headerView.frame = frame;
        self.headerView = headerView;
        self.defautHeaderSize = frame.size;
        scrollView.contentInset = UIEdgeInsetsMake(frame.size.height, 0, 0, 0);
    }
    return self;
}

- (void)scrollViewDidSroll:(UIScrollView *)scrollView superViewInsetHeight:(CGFloat)insetHeight{
    
    CGPoint point = scrollView.contentOffset;
    CGFloat originY = point.y+insetHeight; // headerView的originY
    
    CGRect rect = self.headerView.frame;
    rect.origin.y = originY;
    rect.size.height = - originY;
    self.headerView.frame = rect;
}
@end
