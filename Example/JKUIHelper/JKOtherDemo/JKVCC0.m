//
//  JKVCC0.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2018/1/19.
//  Copyright © 2018年 xindizhiyin2014. All rights reserved.
//

#import "JKVCC0.h"
#import <JKUIHelper/UIView+JKUIHelper.h>
@interface JKVCC0 ()

@end

@implementation JKVCC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addbgColors:@[[UIColor redColor],[UIColor greenColor]] ratios:@[@(0.5),@(0.5)] direction:JKDirectionVertical];
    [self.view addbgColors:@[[UIColor redColor],[UIColor greenColor]] ratios:@[@(0.5),@(0.5)] direction:JKDirectionHorizontal];
    
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
