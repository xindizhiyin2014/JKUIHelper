#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JKScrollViewHelper.h"
#import "JKUIHelper.h"
#import "UIView+JKUIHelper.h"
#import "UIButton+JKHitTest.h"
#import "UIScrollView+JKHitTest.h"
#import "JKCollectionCellProtocol.h"
#import "JKTableCellProtocol.h"
#import "JKViewProtocol.h"
#import "JKRoundCornerView.h"
#import "UIView+JKRoundCorner.h"
#import "JKShadow.h"

FOUNDATION_EXPORT double JKUIHelperVersionNumber;
FOUNDATION_EXPORT const unsigned char JKUIHelperVersionString[];

