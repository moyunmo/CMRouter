//
//  CMDViewController.m
//  CMRouter_Example
//
//  Created by Moyun on 2017/8/20.
//  Copyright © 2017年 momo605654602@gmail.com. All rights reserved.
//

#import "CMDViewController.h"
#import <CMRouter/CMRouter.h>

@interface CMDViewController ()

@end

@implementation CMDViewController

CM_Register_MODULE(user/login);

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Callback" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(callback:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)callback:(id)sender {
    self.routerCallBack(@"tag1", @"call Back data");
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
