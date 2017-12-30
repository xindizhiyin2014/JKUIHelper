//
//  JKVCB0.m
//  JKUIHelper_Example
//
//  Created by JackLee on 2017/12/30.
//  Copyright © 2017年 xindizhiyin2014. All rights reserved.
//

#import "JKVCB0.h"
#import <JKUIHelper/JKUIHelper.h>
@interface JKVCB0 ()<JKTextViewDelegate>

@end

@implementation JKVCB0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JKTextView *testView = [[JKTextView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    NSString *text = @"欢迎查看我的github    <点击查看>";
    JKTextAction *action = [JKTextAction new];
    action.actionScheme = @"readmore";
    action.content = @"<点击查看>";
    action.url = @"https://github.com/xindizhiyin2014/JKUIHelper";
    action.attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor]};
    testView.delegate = self;
    [testView addRichTextAction:action];
     testView.text = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    testView.center = self.view.center;
    [self.view addSubview:testView];
}

- (void)interactWithAction:(JKTextAction *)action{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:action.url]];
    
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
