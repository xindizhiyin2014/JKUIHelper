//
//  JKScrollHelperVC7.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2020/11/11.
//  Copyright © 2020 xindizhiyin2014. All rights reserved.
//

#import "JKScrollHelperVC7.h"
#import <JKUIHelper/JKUIHelper.h>

@interface JKScrollHelperVC7 ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) JKScrollHelper *scrollHelper;
@property (nonatomic,strong) JKScrollHelperImgView *headerView;
@end

@implementation JKScrollHelperVC7

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI{
    self.scrollHelper  = [JKScrollHelper initWithScrollView:self.collectionView headerView:self.headerView style:JKScrollStyleHeaderNormal];
}

#pragma mark - - - - UItableViewDataSource - - - -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (indexPath.item%2 == 0) {
        cell.contentView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    } else {
        cell.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
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
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (JKScrollHelperImgView *)headerView{
    if(!_headerView){
        _headerView = [[JKScrollHelperImgView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        _headerView.image = [UIImage imageNamed:@"123.jpg"];
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

@end
