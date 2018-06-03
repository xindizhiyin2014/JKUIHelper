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
@property (nonatomic,assign) JKScrollStyle scrollStyle;
@property (nonatomic,assign) CGFloat contentInsetTop;
@property (nonatomic,assign) CGFloat originHeaderY;
@end
@implementation JKScrollViewHelper
- (id)initWithScrollView:(UIScrollView *)scrollView headerView:(UIView *)headerView style:(JKScrollStyle)style{
    self = [super init];
    if(self){

        CGRect frame = headerView.frame;
        headerView.clipsToBounds = YES;
        self.headerView = headerView;
        self.scrollStyle = style;
        CGFloat height = 0;
        
        if ([scrollView isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)scrollView;
            if (style == JKScrollStyleHeaderScaleWithSystem) {
                UIView *tableHeaderView = (UITableView *)tableView.tableHeaderView;
                height = tableHeaderView.frame.size.height;
            }else if (style == JKScrollStyleHeaderNormalWithSection){
                CGRect sectionRect = [tableView rectForHeaderInSection:0];
                height = sectionRect.size.height;
            }
            
            
        }
        self.defautHeaderSize = frame.size;
        self.contentInsetTop = frame.size.height-height;
            scrollView.contentInset = UIEdgeInsetsMake(self.contentInsetTop, 0, 0, 0);
            [scrollView setContentOffset:CGPointMake(0, -self.contentInsetTop) animated:NO];
            scrollView.bouncesZoom = NO;
        self.originHeaderY = HUGE_VAL;
    }
    return self;
}

- (void)scrollViewDidSroll:(UIScrollView *)scrollView superViewInsetHeight:(CGFloat)insetHeight{
    
    CGPoint point = scrollView.contentOffset;
    CGFloat originOffsetY = point.y+insetHeight;
//    NSLog(@"originOffsetY %@",@(originOffsetY));
   CGRect rect = self.headerView.frame;
    if (self.originHeaderY == HUGE_VAL) {
        self.originHeaderY = rect.origin.y;
    }
    switch (self.scrollStyle) {
        case JKScrollStyleHeaderNormal:
        {
            if (originOffsetY<= -self.defautHeaderSize.height) {
            rect.origin.y = fabs(originOffsetY)-self.defautHeaderSize.height;
            }else{
            rect.origin.y = -(originOffsetY+self.defautHeaderSize.height);
            }
            rect.size.height = self.defautHeaderSize.height;
            self.headerView.frame = rect;
        }
            break;
        case JKScrollStyleHeaderScale:
        {
           if (originOffsetY< -self.defautHeaderSize.height) {
               rect.origin.y = rect.origin.y;
                rect.size.height = - originOffsetY;
                self.headerView.frame = rect;
           }else if (originOffsetY> -self.defautHeaderSize.height){
                rect.origin.y = -(originOffsetY+self.defautHeaderSize.height);
               rect.size.height = self.defautHeaderSize.height;
               self.headerView.frame = rect;
    
           }
        }
            break;
        case JKScrollStyleHeaderScaleWithSystem:
        {
            if (originOffsetY<= -self.contentInsetTop) {
                rect.origin.y = self.originHeaderY;
                rect.size.height = fabs(originOffsetY)-self.contentInsetTop + self.defautHeaderSize.height;
                self.headerView.frame = rect;
            }else if (originOffsetY> -self.contentInsetTop){
                rect.origin.y = -originOffsetY-self.contentInsetTop;
                rect.size.height = self.defautHeaderSize.height;
                self.headerView.frame = rect;
                
            }
        }
            break;
        case JKScrollStyleHeaderNormalWithSection:
        {
            if (originOffsetY<= -self.contentInsetTop) {
                rect.origin.y = fabs(originOffsetY)-self.contentInsetTop;
            }else{
                rect.origin.y = -originOffsetY-self.contentInsetTop;
            }
            rect.size.height = self.defautHeaderSize.height;
            self.headerView.frame = rect;
        }
            break;
            
        default:
            break;
    }
}
@end
