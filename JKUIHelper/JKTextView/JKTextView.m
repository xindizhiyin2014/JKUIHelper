//
//  JKTextView.m
//  JKUIHelper
//
//  Created by JackLee on 2017/12/30.
//

#import "JKTextView.h"



@implementation JKTextAction

@end


@interface JKTextView()<UITextViewDelegate>

@property (nonatomic,strong) UITextView *textView;      ///< 显示内容的视图
@property (nonatomic,strong) NSMutableArray *actions;   ///< 响应时间配置的数组

@end

@implementation JKTextView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _jkSetup];
    }
    return self;
}


- (void)addRichTextAction:(JKTextAction *)action{
    [self.actions addObject:action];
}


#pragma mark - setter
- (void)setText:(NSAttributedString *)text{
    _text = text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:text];
    NSMutableDictionary *mutableDic = [NSMutableDictionary new];
    for (JKTextAction *action in self.actions) {
        [mutableDic addEntriesFromDictionary:action.attributes];
        if (action.content) {
            NSRange range = [[attributedString string] rangeOfString:action.content];
            [attributedString addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%@://",action.actionScheme] range:range];
        }else{
            NSRange range = action.locationRange;
            if (range.location + range.length <= attributedString.length) {
                [attributedString addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%@://",action.actionScheme] range:range];
                NSString *content = [[text string] substringWithRange:range];
                action.content = content;
            }
            
        }
    }
    
    self.textView.linkTextAttributes = [mutableDic copy];
    self.textView.attributedText = attributedString;
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    for (JKTextAction *action in self.actions) {
        NSString *actionScheme = action.actionScheme;
        if ([[URL scheme] isEqualToString:actionScheme]) {
            if (self.delegate) {
                [self.delegate interactWithAction:action];
            }
            return NO;
        }
    }
    return YES;
}

#pragma mark -setter
- (void)setShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator{
    if (_showsVerticalScrollIndicator != showsVerticalScrollIndicator) {
        self.textView.showsVerticalScrollIndicator =showsVerticalScrollIndicator;
    }
}

- (void)setShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator{
    if (_showsHorizontalScrollIndicator != showsHorizontalScrollIndicator) {
        self.textView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
    }
}


#pragma mark - private Method
- (void)_jkSetup{
        self.actions = [NSMutableArray new];
        self.textView = [[UITextView alloc] initWithFrame:self.bounds];
        self.textView.editable = NO;
        self.textView.delegate = self;
        self.textView.scrollEnabled = NO;
        self.textView.selectable=YES;
        self.textView.dataDetectorTypes = UIDataDetectorTypeLink;
        [self addSubview:self.textView];
}

@end
