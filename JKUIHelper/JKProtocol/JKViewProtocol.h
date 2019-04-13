//
//  JKViewProtocol.h
//  JKUIHelper
//
//  Created by JackLee on 2019/4/13.
//

#ifndef JKViewProtocol_h
#define JKViewProtocol_h
#import <Foundation/Foundation.h>
@protocol JKViewProtocol <NSObject>

@optional

- (void)initSubViews;

- (void)updateViewWithModel:(id)model;

@end

@protocol JKViewDelegate <NSObject>

@optional

- (void)eventOn:(id)view sender:(id)sender extra:(id)extra;

@end

#endif /* JKViewProtocol_h */
