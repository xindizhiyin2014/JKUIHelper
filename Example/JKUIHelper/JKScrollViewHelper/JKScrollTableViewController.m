//
//  JKScrollTableViewController.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2018/6/1.
//  Copyright © 2018年 xindizhiyin2014. All rights reserved.
//

#import "JKScrollTableViewController.h"
#import "JKScrollHelperVC1.h"
#import "JKScrollHelperVC2.h"
#import "JKScrollHelperVC3.h"
#import "JKScrollHelperVC5.h"
#import "JKScrollHelperVC6.h"



@interface JKScrollTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *contentTableView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation JKScrollTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configUI];
}

- (void)configUI{
    self.title = @"JKScrollHelper";
    [self contentTableView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            JKScrollHelperVC1 *vc = [JKScrollHelperVC1 new];
            vc.title = self.dataArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            JKScrollHelperVC2 * vc = [JKScrollHelperVC2 new];
            vc.title = self.dataArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            JKScrollHelperVC3 * vc = [JKScrollHelperVC3 new];
            vc.title = self.dataArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            JKScrollHelperVC5 * vc = [JKScrollHelperVC5 new];
            vc.title = self.dataArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            JKScrollHelperVC6 * vc = [JKScrollHelperVC6 new];
            vc.title = self.dataArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}



#pragma mark - lazyLoad

- (UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        [_contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_contentTableView];
    }
    return _contentTableView;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"头视图弹性拖拽",@"头视图拖拽联动",@"带有用户头像的头视图",@"和MJ结合起来使用",@"添加footer"];
    }
    return _dataArray;
}

@end
