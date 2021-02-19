//
//  JKScrollHelperVC8.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2020/11/11.
//  Copyright © 2020 xindizhiyin2014. All rights reserved.
//

#import "JKScrollHelperVC8.h"
#import <JKUIHelper/JKUIHelper.h>
#import <Masonry/Masonry.h>
#import "JKCollectionViewCell.h"

@interface JKScrollHelperVC8 ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) JKScrollHelper *scrollHelper;
@property (nonatomic,strong) UIView *headerView;
@end

@implementation JKScrollHelperVC8

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    
//    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicked:)];
//        tapGr.delegate = self;
//        [self.view addGestureRecognizer:tapGr];
}

- (void)configUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    JKScrollHelperView *tempView = [[JKScrollHelperView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    tempView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.2];

    UIButton *userIcon = [UIButton new];
    userIcon.backgroundColor = [UIColor redColor];
    [userIcon addTarget:self action:@selector(userIconClicked:) forControlEvents:UIControlEventTouchUpInside];
    userIcon.layer.cornerRadius = 25;
    userIcon.layer.masksToBounds = YES;
    [tempView addSubview:userIcon];
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-50);
        make.centerX.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    JKScrollExtraViewConfig *headerViewConfig = [JKScrollExtraViewConfig new];
    headerViewConfig.frontView = tempView;
    headerViewConfig.backgroundView = self.headerView;
    self.scrollHelper  = [JKScrollHelper initWithScrollView:self.collectionView headerViewCofnig:headerViewConfig commonSuperView:self.view];
}


- (void)userIconClicked:(UIButton *)button{
    NSLog(@"用户头像被点击了");
}

///*3.实现这个代理方法*/
//#pragma mark Delegate for the gestureRecognizer
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    //注意传入的参数是当前的CollectionView对象
//    if ([touch.view isDescendantOfView:self.collectionView]) {
//        return NO;
//    }
//    return YES;
//}

#pragma mark - - - - UItableViewDataSource - - - -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JKCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.item%2 == 0) {
        cell.contentView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    } else {
        cell.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %@",@(indexPath.item));
}

#pragma mark - - - - UIScrollViewDelegate - - - -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.scrollHelper scrollViewDidSroll:scrollView superViewInsetHeight:0];
}

#pragma mark - - - - lazyLoad - - - -
- (NSArray *)datas{
    if(!_datas){
        _datas = @[@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!",@"Hi I'm Jack!"];
    }
    return _datas;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[JKCollectionViewCell class] forCellWithReuseIdentifier:@"JKCollectionViewCell"];
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        [self.view addSubview:_headerView];
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"123.jpg"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = NO;
        [_headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.inset(0);
        }];
    }
    return _headerView;
}

@end
