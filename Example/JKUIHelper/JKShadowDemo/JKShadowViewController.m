//
//  JKShadowViewController.m
//  JKShadow
//
//  Created by HHL110120 on 11/07/2017.
//  Copyright (c) 2017 HHL110120. All rights reserved.
//

#import "JKShadowViewController.h"

@interface JKShadowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *contentTableView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation JKShadowViewController

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
    NSString *vcClassName = [NSString stringWithFormat:@"JKVC%lu",indexPath.row];
    UIViewController *vc = (UIViewController *)[NSClassFromString(vcClassName) new];
    vc.title = self.dataArray[indexPath.row];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
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
        _dataArray = @[@"给UIView添加阴影",@"给圆形的UIView添加阴影",@"给带圆角的UIView添加阴影",@"自定义形状添加阴影"];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
