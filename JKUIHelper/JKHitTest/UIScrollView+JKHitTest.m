//
//  UIScrollView+JKHitTest.m
//  JKUIHelper
//
//  Created by JackLee on 2018/6/4.
//

#import "UIScrollView+JKHitTest.h"
#import <objc/runtime.h>

@implementation UIScrollView (JKHitTest)
static char jkRealRespondViewIdentifier;

- (NSArray <UIView *>*)jkRealRespondViews{
    return objc_getAssociatedObject(self, &jkRealRespondViewIdentifier);
}

- (void)setJkRealRespondViews:(NSArray <UIView *>*)jkRealRespondViews{
    objc_setAssociatedObject(self, &jkRealRespondViewIdentifier, jkRealRespondViews, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    if (self.jkRealRespondViews.count >0) {
        for (UIView *jkRealRespondView in self.jkRealRespondViews) {
            CGPoint tempoint = [jkRealRespondView convertPoint:point fromView:self];
            if (CGRectContainsPoint(jkRealRespondView.bounds, tempoint)){
                UIView *view= [jkRealRespondView hitTest:tempoint withEvent:event];
                if (view ) {
                    return view;
                }
                
            }
        }
        }
        
    
    return [super hitTest:point withEvent:event];
}

@end
