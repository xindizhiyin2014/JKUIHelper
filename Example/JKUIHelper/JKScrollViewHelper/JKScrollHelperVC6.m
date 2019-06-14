//
//  JKScrollHelperVC6.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2019/5/30.
//  Copyright © 2019 xindizhiyin2014. All rights reserved.
//

#import "JKScrollHelperVC6.h"
#import <JKUIHelper/JKUIHelper.h>

@interface JKScrollHelperVC6 ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) JKScrollHelper *scrollHelper;
@property (nonatomic,strong) JKScrollHelperImgView *headerView;
@property (nonatomic,strong) JKScrollHelperView *footerView;

@end

@implementation JKScrollHelperVC6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    tableFooterView.backgroundColor = [UIColor greenColor];
    self.tableView.tableFooterView = tableFooterView;
    self.tableView.backgroundColor = [UIColor yellowColor];
    self.scrollHelper  = [JKScrollHelper  initWithScrollView:self.tableView headerView:self.headerView style:JKScrollStyleHeaderScale];
    [self.scrollHelper addFooterView:self.footerView];
//    self.scrollHelper = [JKScrollViewHelper initWithScrollView:self.tableView footerView:self.footerView];
    
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
        _datas = @[@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!"];
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

- (JKScrollHelperImgView *)headerView{
    if(!_headerView){
        _headerView = [[JKScrollHelperImgView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        _headerView.image = [UIImage imageNamed:@"123.jpg"];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (JKScrollHelperView *)footerView{
    if (!_footerView) {
        _footerView = [[JKScrollHelperView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        _footerView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_footerView];
    }
    return _footerView;
}

@end
