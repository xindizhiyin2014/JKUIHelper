//
//  JKRoundCornerView.m
//  JKUIHelper
//
//  Created by JackLee on 2017/12/30.
//

#import "JKRoundCornerView.h"
@interface JKRoundCornerView ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end


@implementation JKRoundCornerView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _jkSetup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _jkSetup];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self _jkChangeLayerPath];
}


- (void)setJkCorners:(UIRectCorner)jkCorners{
    if (_jkCorners != jkCorners) {
        _jkCorners = jkCorners;
        [self _jkChangeLayerPath];
    }
}

- (void)setJkCornerRadius:(CGFloat)jkCornerRadius{
    if (_jkCornerRadius != jkCornerRadius) {
        _jkCornerRadius = jkCornerRadius;
        [self _jkChangeLayerPath];
    }
}

#pragma mark - Private
- (void)_jkSetup{
        _jkCornerRadius = 5.0f;
        _jkCorners = UIRectCornerAllCorners;
}

- (void)_jkChangeLayerPath{
    if (!self.maskLayer) {
        self.maskLayer = [CAShapeLayer layer];
        self.layer.mask = self.maskLayer;
    }
    self.maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                byRoundingCorners: self.jkCorners
                                                      cornerRadii: (CGSize){self.jkCornerRadius,self.jkCornerRadius}].CGPath;
}

@end
