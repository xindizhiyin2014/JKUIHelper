//
//  JKSavePictureView.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2022/4/5.
//  Copyright © 2022 xindizhiyin2014. All rights reserved.
//

#import "JKSavePictureView.h"
#import <Masonry/Masonry.h>
#import "UIImage+JKCategories.h"

@interface JKSavePictureView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation JKSavePictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupConstraints];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.tableView];
}

- (void)setupConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
}

- (void)createPicture
{
    self.datas = @[@"dfdfdf",@"gttgt",@"cecece",@"ttt",@"jjj",@"uuu",@"uuu",@"oo",@"opop"];
    [self.tableView reloadData];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [NSString stringWithFormat:@"%@/123.png",DocumentsPath];
    NSLog(@"path:%@",path);
    UIImage *image = [UIImage jkImgOfView:self];
    [image saveToPath:path];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor redColor];
    }
    NSString *title = self.datas[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - - getter - -
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
