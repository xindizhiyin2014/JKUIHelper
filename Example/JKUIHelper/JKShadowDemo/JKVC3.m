//
//  JKVC3.m
//  JKShadow_Example
//
//  Created by Jack on 2017/11/9.
//  Copyright © 2017年 HHL110120. All rights reserved.
//

#import "JKVC3.h"
#import "JKView3.h"

@interface JKVC3 ()

@end

@implementation JKVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JKView3 *view = [[JKView3 alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
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
