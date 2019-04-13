//
//  JKCollectionCellProtocol.h
//  JKUIHelper
//
//  Created by JackLee on 2019/4/13.
//

#ifndef JKCollectionCellProtocol_h
#define JKCollectionCellProtocol_h
#import <Foundation/Foundation.h>
@protocol JKCollectionCellProtocol <NSObject>

@optional
/**
 单元格内容缩进
 
 @return 缩进
 */
+ (UIEdgeInsets)itemInsets;


/**
 每一行的单元格数量，默认是 1
 
 @return 数量
 */
+ (NSInteger)cellNumInRow;

/**
 单元格行间距
 
 @return 行间距
 */
+ (CGFloat)itemMinLineSpacing;

/**
 单元格列间距
 
 @return 列间距
 */
+ (CGFloat)itemMinInterSpacing;

/**
 单元格的size
 
 @return CGSize
 */
+ (CGSize)itemSize;

+ (NSString *)cellIdentifier;


@end

@protocol JKCollectionCellDelegate <NSObject>

@optional

- (void)cell:(UICollectionViewCell *)cell didClickedBtn:(UIButton *)button type:(NSInteger)type data:(id)data;

- (void)cell:(UICollectionViewCell *)cell didClickedBtn:(UIButton *)button type:(NSInteger)type data:(id)data extra:(id)extra;

@end

#endif /* JKCollectionCellProtocol_h */
