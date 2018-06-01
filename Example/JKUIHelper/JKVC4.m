//
//  JKVC1.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2018/5/30.
//  Copyright © 2018年 xindizhiyin2014. All rights reserved.
//

#import "JKVC4.h"
#import <JKUIHelper/JKUIHelper.h>
@interface JKVC4 ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) JKScrollViewHelper *scrollHelper;
@property (nonatomic,strong) UIImageView *headerView;
@end

@implementation JKVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"JKScrollHelper";
    [self configUI];
}
- (void)configUI{
    

    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [UIView new];
    self.scrollHelper  = [[JKScrollViewHelper alloc] initWithScrollView:self.tableView headerView:self.headerView style:JKScrollHeaderViewStyleNormal];
}

#pragma mark - - - - UItableViewDataSource - - - -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *tempHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    tempHeaderView.backgroundColor = [UIColor redColor];
    tempHeaderView.alpha = 0.3;
    return tempHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

#pragma mark - - - - UIScrollViewDelegate - - - -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.scrollHelper scrollViewDidSroll:scrollView superViewInsetHeight:0];
}

#pragma mark - - - - lazyLoad - - - -
- (NSArray *)datas{
    if(!_datas){
        _datas = @[@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!"];
    }
    return _datas;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIImageView *)headerView{
    if(!_headerView){
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        _headerView.image = [UIImage imageNamed:@"123.jpg"];
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerView;
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
