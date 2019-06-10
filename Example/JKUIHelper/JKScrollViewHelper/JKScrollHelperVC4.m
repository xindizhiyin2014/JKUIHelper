//
//  JKScrollHelperVC2.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2018/6/1.
//  Copyright © 2018年 xindizhiyin2014. All rights reserved.
//

#import "JKScrollHelperVC4.h"
#import <JKUIHelper/JKUIHelper.h>
@interface JKScrollHelperVC4 ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) JKScrollViewHelper *scrollHelper;
@property (nonatomic,strong) UIImageView *headerView;
@end

@implementation JKScrollHelperVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
    self.view.backgroundColor = [UIColor greenColor];
    [self.view insertSubview:self.headerView belowSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [UIView new];
    
    self.scrollHelper  = [JKScrollViewHelper  initWithScrollView:self.tableView headerView:self.headerView style:JKScrollStyleHeaderNormalWithSection];
    self.tableView.jkRealRespondViews = @[self.headerView];
}

#pragma mark - - - - UItableViewDataSource - - - -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    sectionHeader.backgroundColor = [UIColor clearColor];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 30)];
    contentView.backgroundColor = [UIColor redColor];
    UILabel *label = [UILabel new];
    label.text = @"I'm section Header";
    label.frame = CGRectMake(0, 0, 150, 30);
    [contentView addSubview:label];
    label.center = contentView.center;
    [sectionHeader addSubview:contentView];
    
    return sectionHeader;
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

- (void)userIconClicked:(UIButton *)button{
    NSLog(@"用户头像被点击了");
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
        _headerView.userInteractionEnabled = YES;
        UIButton *userIcon = [UIButton new];
        userIcon.frame = CGRectMake(0, 0, 50, 50);
        userIcon.backgroundColor = [UIColor redColor];
        [userIcon addTarget:self action:@selector(userIconClicked:) forControlEvents:UIControlEventTouchUpInside];
        userIcon.layer.cornerRadius = 25;
        userIcon.layer.masksToBounds = YES;
        [_headerView addSubview:userIcon];
        userIcon.center = _headerView.center;
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
