//
//  JKVC0.m
//  JKShadow_Example
//
//  Created by Jack on 2017/11/9.
//  Copyright © 2017年 HHL110120. All rights reserved.
//

#import "JKVC0.h"
#import <JKUIHelper/JKShadow.h>

@interface JKVC0 ()

@end

@implementation JKVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    view.center = self.view.center;
    [self.view addSubview:view];
    [JKShadow drawShadowOnView:view shadowColor:[UIColor blackColor] offset:CGSizeMake(3, 5) opacity:0.8];
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
