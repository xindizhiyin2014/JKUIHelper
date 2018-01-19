//
//  JKOtherDemoViewController.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2018/1/19.
//  Copyright © 2018年 xindizhiyin2014. All rights reserved.
//

#import "JKOtherDemoViewController.h"

@interface JKOtherDemoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation JKOtherDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self contentTableView];
}



#pragma mark - lazyLoad
- (NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = @[@"为视图绘制不同颜色的背景"];
    }
    return _dataArray;
}

- (UITableView *)contentTableView{
    if(!_contentTableView){
        _contentTableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _contentTableView.dataSource =self;
        _contentTableView.delegate = self;
        [_contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_contentTableView];
    }
    return _contentTableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcClassName = [NSString stringWithFormat:@"JKVCC%ld",indexPath.row];
    UIViewController *vc = (UIViewController *)[NSClassFromString(vcClassName) new];
    vc.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
