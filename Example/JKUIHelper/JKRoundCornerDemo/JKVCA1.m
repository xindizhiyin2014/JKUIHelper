//
//  JKVCA1.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2017/12/30.
//  Copyright © 2017年 xindizhiyin2014. All rights reserved.
//

#import "JKVCA1.h"
#import <JKUIHelper/JKUIHelper.h>
@interface JKVCA1 ()

@end

@implementation JKVCA1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.backgroundColor = [UIColor redColor];
//    [testView jkDrawRoundCornerWithCorners:UIRectCornerTopLeft radius:25.0f];
    [testView jkDrawRoundCornerWithRect:CGRectMake(0, 0, 100, 100) Corners:UIRectCornerTopLeft radius:25.0f];
    testView.center = self.view.center;
    [self.view addSubview:testView];
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
