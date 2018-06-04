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
#import "JKHitTestButton.h"
#import "UIScrollView+JKHitTest.h"
#import "JKRoundCornerView.h"
#import "UIView+JKRoundCorner.h"
#import "JKShadow.h"
#import "JKTextView.h"

FOUNDATION_EXPORT double JKUIHelperVersionNumber;
FOUNDATION_EXPORT const unsigned char JKUIHelperVersionString[];

