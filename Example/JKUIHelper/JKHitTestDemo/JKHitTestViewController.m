//
//  JKHitTestViewController.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2018/6/26.
//  Copyright © 2018年 xindizhiyin2014. All rights reserved.
//

#import "JKHitTestViewController.h"
#import "UIButton+JKHitTest.h"

@interface JKHitTestViewController ()

@end

@implementation JKHitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
UIButton *button = [UIButton new];
[button setTitle:@"点击" forState:UIControlStateNormal];
[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
button.frame = CGRectMake(0, 0, 100, 30);
    button.backgroundColor = [UIColor redColor];
button.center = self.view.center;
[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.hitTestInsets = UIEdgeInsetsMake(15, 50, 15, 50);//热区范围为0
    //button.hitTestInsets = UIEdgeInsetsMake(-15, -15, -15, -15);//热区范围为0
[self.view addSubview:button];

}

#pragma mark - - - - UIEvent - - - -
- (void)buttonClicked:(UIButton *)button{
    NSLog(@"AAAAAA");
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
