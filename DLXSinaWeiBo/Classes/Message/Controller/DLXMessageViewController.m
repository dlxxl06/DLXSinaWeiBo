//
//  DLXMessageViewController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXMessageViewController.h"
#import "UIBarButtonItem+DLX.h"

@interface DLXMessageViewController ()

@end

@implementation DLXMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"消息";
    UIBarButtonItem *find = [UIBarButtonItem ButtonWithNormalTitle:@"发现群" target:self action:@selector(tapFindGroup)];
    UIBarButtonItem *chat = [UIBarButtonItem ButtonWithNormalTitle:@"发起聊天" target:self action:@selector(tapStartChat)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[space,find];
    self.navigationItem.rightBarButtonItems = @[space,chat];
}
-(void)tapFindGroup
{

}
-(void)tapStartChat
{

}
@end
