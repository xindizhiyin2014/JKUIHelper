//
//  JKTableCellProtocol.h
//  JKUIHelper
//
//  Created by JackLee on 2019/4/13.
//

#ifndef JKTableCellProtocol_h
#define JKTableCellProtocol_h

#import <Foundation/Foundation.h>


@protocol JKTableCellProtocol <NSObject>

@optional

+ (CGFloat)cellHeight;

+ (CGFloat)estimatedCellHeight;

+ (NSString *)cellIdentifier;


@end


@protocol JKTableCellDelegate <NSObject>

@optional

- (void)cell:(UITableViewCell *)cell sender:(id)sender type:(NSInteger)type data:(id)data;

- (void)cell:(UITableViewCell *)cell sender:(id)sender type:(NSInteger)type data:(id)data extra:(id)extra;

- (void)cell:(UITableViewCell *)cell sender:(id)sender type:(NSInteger)type data:(id)data extra:(id)extra complete:(void(^)(id data))complete;


@end

#endif /* JKTableCellProtocol_h */
