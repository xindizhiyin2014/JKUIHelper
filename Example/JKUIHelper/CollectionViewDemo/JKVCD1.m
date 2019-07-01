//
//  JKVCD1.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2019/6/30.
//  Copyright © 2019 xindizhiyin2014. All rights reserved.
//

#import "JKVCD1.h"
#import "XLCardSwitchFlowLayout.h"
#import "JKCollectionViewCell1.h"

@interface JKVCD1 ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableArray *visibleDatas;
@end

@implementation JKVCD1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refresh];
}

- (void)refresh{
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];

}

#pragma mark - - - - lazyLoad - - - -
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        XLCardSwitchFlowLayout *layout = [XLCardSwitchFlowLayout new];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        layout.sectionInset =UIEdgeInsetsZero;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        [_collectionView registerClass:[JKCollectionViewCell1 class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}

- (NSMutableArray *)visibleDatas{
    if (!_visibleDatas) {
        _visibleDatas = [NSMutableArray new];
    }
    return _visibleDatas;
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
