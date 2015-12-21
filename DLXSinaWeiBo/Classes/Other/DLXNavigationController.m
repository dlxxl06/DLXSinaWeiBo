//
//  DLXNavigationController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXNavigationController.h"

@implementation DLXNavigationController
-(void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
}
@end