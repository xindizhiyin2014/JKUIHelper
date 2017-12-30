//
//  JKVCA0.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2017/12/30.
//  Copyright © 2017年 xindizhiyin2014. All rights reserved.
//

#import "JKVCA0.h"
#import <JKUIHelper/JKUIHelper.h>
@interface JKVCA0 ()

@end

@implementation JKVCA0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JKRoundCornerView *testView = [[JKRoundCornerView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.jkCorners = UIRectCornerTopRight;
    testView.jkCornerRadius = 20.0f;
    testView.backgroundColor = [UIColor redColor];
    
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
