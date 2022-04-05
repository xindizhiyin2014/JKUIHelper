//
//  JKSavePictureViewController.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2022/4/5.
//  Copyright © 2022 xindizhiyin2014. All rights reserved.
//

#import "JKSavePictureViewController.h"
#import "JKSavePictureView.h"

@interface JKSavePictureViewController ()

@end

@implementation JKSavePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(0, 0, 60, 60);
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.center = self.view.center;
}

- (void)buttonClicked:(UIButton *)button
{
    JKSavePictureView *view = [[JKSavePictureView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [view createPicture];
    
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
