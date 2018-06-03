//
//  JKScrollHelperVC1.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2018/6/1.
//  Copyright © 2018年 xindizhiyin2014. All rights reserved.
//

#import "JKScrollHelperVC3.h"
#import <JKUIHelper/JKUIHelper.h>
@interface JKScrollHelperVC3 ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) JKScrollViewHelper *scrollHelper;
@property (nonatomic,strong) UIImageView *headerView;
@end

@implementation JKScrollHelperVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    tempView.backgroundColor = [UIColor clearColor];
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    userIcon.backgroundColor = [UIColor redColor];
    userIcon.layer.cornerRadius = 25;
    userIcon.layer.masksToBounds = YES;
    [tempView addSubview:userIcon];
    userIcon.center = tempView.center;
    self.tableView.tableHeaderView = tempView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.scrollHelper  = [[JKScrollViewHelper alloc] initWithScrollView:self.tableView headerView:self.headerView style:JKScrollStyleHeaderScaleWithSystem];
    [self.view insertSubview:self.headerView belowSubview:self.tableView];
    
}

#pragma mark - - - - UItableViewDataSource - - - -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
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
        [self.view addSubview:_headerView];
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
