//
//  CMBViewController.m
//  CMRouter_Example
//
//  Created by Moyun on 2017/8/20.
//  Copyright © 2017年 momo605654602@gmail.com. All rights reserved.
//

#import "CMBViewController.h"
#import <CMRouter/CMRouter.h>

@interface CMBViewController ()<CMRouterProtocol>

@end

@implementation CMBViewController

CM_Register_MODULE(user/注册);

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
