//
//  JKViewController.m
//  JKUIHelper
//
//  Created by xindizhiyin2014 on 12/30/2017.
//  Copyright (c) 2017 xindizhiyin2014. All rights reserved.
//

#import "JKViewController.h"
#import "JKShadowViewController.h"
#import "JKRoundCornerDemoViewController.h"
#import "JKTextViewDemoViewController.h"

@interface JKViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *contentTableView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation JKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configUI];
}

- (void)configUI{
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
                JKShadowViewController *jkShadowVC = [JKShadowViewController new];
                [self.navigationController pushViewController:jkShadowVC animated:YES];
            }
            break;
        case 1:
        {
            JKRoundCornerDemoViewController * jkRoundCornerVC = [JKRoundCornerDemoViewController new];
            [self.navigationController pushViewController:jkRoundCornerVC animated:YES];
        }
            break;
        case 2:
        {
            JKTextViewDemoViewController *jkTextViewVC = [JKTextViewDemoViewController new];
            [self.navigationController pushViewController:jkTextViewVC animated:YES];
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
        _dataArray = @[@"JKShadowDemo",@"JKRoudCornerDemo",@"JKTextViewDemo"];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
