//
//  CMCViewController.m
//  CMRouter_Example
//
//  Created by Moyun on 2017/8/20.
//  Copyright © 2017年 momo605654602@gmail.com. All rights reserved.
//

#import "CMCViewController.h"
#import <CMRouter/CMRouter.h>

@interface CMCViewController ()

@end

@implementation CMCViewController

CM_Register_MODULE(user/info);

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
