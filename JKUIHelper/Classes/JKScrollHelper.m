//
//  JKScrollHelper.m
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import "JKScrollHelper.h"

@interface JKScrollHelperView()

@property (nonatomic,weak) UIScrollView *jk_scrollHelper_Scroll;

@end;

@implementation JKScrollHelperView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.bounds, point)) {
        for (UIView *subView in self.subviews) {
            CGPoint tempoint = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tempoint)){
                UIView *view= [subView hitTest:tempoint withEvent:event];
                if (view) {
                    return view;
                }

            }
        }

        if (self.jk_scrollHelper_Scroll) {
            return self.jk_scrollHelper_Scroll;
        }
    }

    return [super hitTest:point withEvent:event];

}

@end

@interface JKScrollHelperImgView()

@property (nonatomic,weak) UIScrollView *jk_scrollHelper_Scroll;

@end;

@implementation JKScrollHelperImgView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.bounds, point)) {
        for (UIView *subView in self.subviews) {
            CGPoint tempoint = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tempoint)){
                UIView *view= [subView hitTest:tempoint withEvent:event];
                if (view) {
                    return view;
                }
                
            }
        }
        
        if (self.jk_scrollHelper_Scroll) {
            return self.jk_scrollHelper_Scroll;
        }
    }
    
    return [super hitTest:point withEvent:event];
    
}

@end

@interface JKScrollHelper()

@property (nonatomic,assign)CGSize defautHeaderSize;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIView *headerView;
@property (nonatomic,weak) UIView *footerView;
@property (nonatomic,assign) JKScrollStyle scrollStyle;
@property (nonatomic,assign) CGFloat contentInsetTop;
@property (nonatomic,assign) CGFloat contentInsetBottom;
@property (nonatomic,assign) CGFloat originHeaderY;

@end

@implementation JKScrollHelper

+ (instancetype)initWithScrollView:(UIScrollView *)scrollView headerView:(UIView *)headerView style:(JKScrollStyle)style{
    if (!([headerView isKindOfClass:[JKScrollHelperView class]] || [headerView isKindOfClass:[JKScrollHelperImgView class]])) {
        NSAssert(NO, @"headerView must be kind of class JKScrollHelperView or JKScrollHelperImgView");
    }
    
    JKScrollHelper *scrollViewHelper = [[self alloc] init];
    if(scrollViewHelper){

        CGRect frame = headerView.frame;
        headerView.clipsToBounds = YES;
        scrollViewHelper.headerView = headerView;
        scrollViewHelper.scrollStyle = style;
        scrollViewHelper.scrollView = scrollView;
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
        scrollViewHelper.defautHeaderSize = frame.size;
        scrollViewHelper.contentInsetTop = frame.size.height-height;
        scrollViewHelper.contentInsetBottom = 0;
        scrollView.contentInset = UIEdgeInsetsMake(scrollViewHelper.contentInsetTop, 0, scrollViewHelper.contentInsetBottom, 0);
        [scrollView setContentOffset:CGPointMake(0, -scrollViewHelper.contentInsetTop) animated:NO];
        scrollView.bouncesZoom = NO;
        scrollViewHelper.originHeaderY = HUGE_VAL;
        if ([headerView isKindOfClass:[JKScrollHelperView class]]) {
            JKScrollHelperView *tmpHeaderView = (JKScrollHelperView *)headerView;
            tmpHeaderView.jk_scrollHelper_Scroll = scrollView;
        }else if ([headerView isKindOfClass:[JKScrollHelperImgView class]]){
            JKScrollHelperImgView *tmpHeaderView = (JKScrollHelperImgView *)headerView;
            tmpHeaderView.jk_scrollHelper_Scroll = scrollView;
        }
        
    }
    return scrollViewHelper;
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
           if (originOffsetY<= -self.defautHeaderSize.height) {
               rect.origin.y = self.originHeaderY;
                rect.size.height = - originOffsetY;
           }else if (originOffsetY> -self.defautHeaderSize.height){
               rect.origin.y = -(originOffsetY+self.defautHeaderSize.height);
               rect.size.height = self.defautHeaderSize.height;
           }
            self.headerView.frame = rect;
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
    if (self.footerView) {
        CGFloat footerOriginY = self.headerView.frame.origin.y + self.headerView.frame.size.height + scrollView.contentSize.height;
        CGRect rect = self.footerView.frame;
        rect.origin.y = footerOriginY;
        self.footerView.frame = rect;
        
    }
}

- (void)scrollViewDidSroll:(UIScrollView *)scrollView offsetY:(CGFloat)offsetY superViewInsetHeight:(CGFloat)insetHeight{
//    CGPoint point = scrollView.contentOffset;
    CGFloat originOffsetY = offsetY+insetHeight;
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
    if (self.footerView) {
        CGFloat footerOriginY = self.headerView.frame.origin.y + self.headerView.frame.size.height + scrollView.contentSize.height;
        CGRect rect = self.footerView.frame;
        rect.origin.y = footerOriginY;
        self.footerView.frame = rect;
        
    }
}

+ (instancetype)initWithScrollView:(UIScrollView *)scrollView footerView:(UIView *)footerView{
    if (!([footerView isKindOfClass:[JKScrollHelperView class]] || [footerView isKindOfClass:[JKScrollHelperImgView class]])) {
        NSAssert(NO, @"headerView must be kind of class JKScrollHelperView or JKScrollHelperImgView");
    }
     JKScrollHelper *scrollViewHelper = [[self alloc] init];
    if (scrollViewHelper) {
        CGRect frame = footerView.frame;
        footerView.clipsToBounds = YES;
        scrollViewHelper.footerView = footerView;
        scrollViewHelper.scrollStyle = JKScrollStyleHeaderNormal;
        
        scrollViewHelper.contentInsetTop = 0;
        scrollViewHelper.contentInsetBottom = frame.size.height;
        scrollView.contentInset = UIEdgeInsetsMake(scrollViewHelper.contentInsetTop, 0, scrollViewHelper.contentInsetBottom, 0);
        [scrollView setContentOffset:CGPointMake(0, -scrollViewHelper.contentInsetTop) animated:NO];
        scrollView.bouncesZoom = NO;
        scrollViewHelper.originHeaderY = HUGE_VAL;
        if ([footerView isKindOfClass:[JKScrollHelperView class]]) {
            JKScrollHelperView *tmpFooterView = (JKScrollHelperView *)footerView;
            tmpFooterView.jk_scrollHelper_Scroll = scrollView;
        }else if ([footerView isKindOfClass:[JKScrollHelperImgView class]]){
            JKScrollHelperImgView *tmpFooterView = (JKScrollHelperImgView *)footerView;
            tmpFooterView.jk_scrollHelper_Scroll = scrollView;
        }
        
    }
    return scrollViewHelper;
}

- (void)addFooterView:(JKScrollHelperView *)footerView{
    if (!([footerView isKindOfClass:[JKScrollHelperView class]] || [footerView isKindOfClass:[JKScrollHelperImgView class]])) {
        NSAssert(NO, @"headerView must be kind of class JKScrollHelperView or JKScrollHelperImgView");
    }
    CGRect frame = footerView.frame;
    footerView.clipsToBounds = YES;
    if ([footerView isKindOfClass:[JKScrollHelperView class]]) {
        JKScrollHelperView *tmpFooterView = (JKScrollHelperView *)footerView;
        tmpFooterView.jk_scrollHelper_Scroll = self.scrollView;
    }else if ([footerView isKindOfClass:[JKScrollHelperImgView class]]){
        JKScrollHelperImgView *tmpFooterView = (JKScrollHelperImgView *)footerView;
        tmpFooterView.jk_scrollHelper_Scroll = self.scrollView;
    }
    self.footerView = footerView;
    self.contentInsetBottom = frame.size.height;
    self.scrollView.contentInset = UIEdgeInsetsMake(self.contentInsetTop, 0, self.contentInsetBottom, 0);
    
}


@end
