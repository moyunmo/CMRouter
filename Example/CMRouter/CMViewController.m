//
//  CMViewController.m
//  CMRouter
//
//  Created by momo605654602@gmail.com on 8/20/2017.
//  Copyright (c) 2017 momo605654602@gmail.com. All rights reserved.
//

#import "CMViewController.h"
#import <CMRouter/CMRouter.h>


@interface CMViewController ()

@end


@implementation CMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc;
    if (indexPath.row == 0) {
        vc = [[CMRouter sharedInstance] controllerWithURL:@"Cmall://user/info"];
    } else if (indexPath.row == 1) {
//        vc = [[CMRouter sharedInstance] controllerWithURL:@"Cmall://user/register?name=moyun&password=123456"];
        vc = [[CMRouter sharedInstance] controllerWithURL:@"user/register" userInfo:@{@"name":@"moyun",@"password":@"123456"}];
    } else if (indexPath.row == 2) {
        vc = [[CMRouter sharedInstance] controllerWithURL:@"user/login" userInfo:@{@"name":@"moyun",@"password":@"123456"} complete:^(NSString *tag, id result) {
            NSLog(@"我是回调tag:%@,我是回调数据:%@",tag,result);
        }];
    }
    NSLog(@"%@",vc.routerParamater);
    [self.navigationController pushViewController:vc animated:YES];
}

@end
