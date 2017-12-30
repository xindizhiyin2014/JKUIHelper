//
//  JKTextView.h
//  JKUIHelper
//
//  Created by JackLee on 2017/12/30.
//

#import <UIKit/UIKit.h>

@class JKTextAction;

@protocol JKTextViewDelegate<NSObject>

- (void)interactWithAction:(nonnull JKTextAction *)action;

@end

@interface JKTextAction:NSObject

@property (nonnull,nonatomic,copy) NSString * actionScheme;         ///< the scheme to recogize the action
@property (nonatomic,assign)NSRange locationRange;                  ///< the range of the action words
@property (nonnull,nonatomic,strong) NSDictionary *attributes;      ///< the configuration of the action words
@property (nullable,nonatomic,copy) NSString *content;              ///< the content of action words if you set the content you need not to set the locationRange,but if you don't set the content you should set the locationRange.^_^
@property (nullable,nonatomic,copy) NSString *url;                  ///< the url need to interact with

@end

@interface JKTextView : UIView

@property (nonnull,nonatomic,copy) NSAttributedString *text;                  ///< show the content
@property (nullable,nonatomic,weak)id<JKTextViewDelegate> delegate;
@property(nonatomic,assign) BOOL scrollEnabled;
@property(nonatomic,assign) BOOL showsHorizontalScrollIndicator; // default YES. show indicator while we are tracking. fades out after tracking
@property(nonatomic,assign) BOOL showsVerticalScrollIndicator;   // default YES. show indicator while we are tracking. fades out after tracking

/**
 add the words action
 
 @param action the words action
 */
- (void)addRichTextAction:(nonnull JKTextAction *)action;

@end
