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
@property (nonatomic,assign) JKScrollHeaderViewStyle headerViewStyle;
@end
@implementation JKScrollViewHelper
- (id)initWithScrollView:(UIScrollView *)scrollView headerView:(UIView *)headerView style:(JKScrollHeaderViewStyle)style{
    self = [super init];
    if(self){
        [scrollView addSubview:headerView];
        if (style ==JKScrollHeaderViewStyleNormal) {
            [scrollView insertSubview:headerView atIndex:0];
        }
        CGRect frame = headerView.frame;
        frame.origin.y = -frame.size.height;
        headerView.frame = frame;
        self.headerView = headerView;
        self.defautHeaderSize = frame.size;
        scrollView.contentInset = UIEdgeInsetsMake(frame.size.height, 0, 0, 0);
        self.headerViewStyle = style;
    }
    return self;
}

- (void)scrollViewDidSroll:(UIScrollView *)scrollView superViewInsetHeight:(CGFloat)insetHeight{
    
    CGPoint point = scrollView.contentOffset;
    CGFloat originY = point.y+insetHeight; // headerView的originY
    switch (self.headerViewStyle) {
        case JKScrollHeaderViewStyleNormal:
        {
            CGRect rect = self.headerView.frame;
            rect.origin.y = -self.defautHeaderSize.height;
            rect.size.height = self.defautHeaderSize.height;
            self.headerView.frame = rect;
        }
            break;
        case JKScrollHeaderViewStyleScale:
        {
            CGRect rect = self.headerView.frame;
            if(-originY<=self.defautHeaderSize.height){
                originY = -self.defautHeaderSize.height;
            }
            rect.origin.y = originY;
            rect.size.height = - originY;
            self.headerView.frame = rect;
        }
            break;
            
        default:
            break;
    }
}
@end
