//
//  UIView+JKHitTest.m
//  JKUIHelper
//
//  Created by JackLee on 2018/6/4.
//

#import "UIView+JKHitTest.h"
#import <objc/runtime.h>
@implementation UIView (JKHitTest)
static char jkRealRespondViewIdentifier;

- (UIView *)jkRealRespondView{
    return objc_getAssociatedObject(self, &jkRealRespondViewIdentifier);
}

- (void)setJkRealRespondView:(UIView *)jkRealRespondView{
    objc_setAssociatedObject(self, &jkRealRespondViewIdentifier, jkRealRespondView, OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    if (self.jkRealRespondView) {
        CGPoint tempoint = [self.jkRealRespondView convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.jkRealRespondView.bounds, tempoint)){
            UIView *view= [self.jkRealRespondView hitTest:point withEvent:event];
            if (view) {
                return view;
            }
            
        }
    }
      return [self.superview hitTest:point withEvent:event];
}

@end
