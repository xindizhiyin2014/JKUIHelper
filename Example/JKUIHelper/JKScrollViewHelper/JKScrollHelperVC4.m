//
//  JKScrollHelperVC4.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2018/6/6.
//  Copyright © 2018年 xindizhiyin2014. All rights reserved.
//

#import "JKScrollHelperVC4.h"
#import <JKUIHelper/JKUIHelper.h>
#import <MJRefresh/MJRefresh.h>
#import "JKRefreshHeader.h"

@interface JKScrollHelperVC4 ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) JKScrollViewHelper *scrollHelper;
@property (nonatomic,strong) UIImageView *headerView;
@property (nonatomic,strong) JKRefreshHeader *refreshHeader;
@end

@implementation JKScrollHelperVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void)configUI{
    JKRefreshHeader *refreshHeader = [JKRefreshHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新啦！！！！");
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_header = refreshHeader;
    
    JKScrollExtraViewConfig *config = [JKScrollExtraViewConfig new];
    config.backgroundView = self.headerView;
//    config.frontView = self.frontView;
    config.headerStyle = JKHeaderBackStyleExpand;
    self.scrollHelper  = [JKScrollViewHelper initWithScrollView:self.tableView headerViewConfig:config];
/*
 collectionView 可以参考如下代码
 JKScrollExtraViewConfig *config = [JKScrollExtraViewConfig new];
 config.backgroundView = self.headerView;
//    config.frontView = self.frontView;
 config.headerStyle = JKHeaderBackStyleExpand;
 self.scrollHelper  = [JKScrollViewHelper initWithScrollView:self.collectionView headerViewConfig:config];
 */
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



#pragma mark - - - - lazyLoad - - - -
- (NSArray *)datas{
    if(!_datas){
        _datas = @[@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!"];
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
        _headerView.userInteractionEnabled = YES;
       
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
