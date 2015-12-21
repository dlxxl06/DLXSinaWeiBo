
//
//  DLXMeViewController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXMeViewController.h"
#import "UIBarButtonItem+DLX.h"
#import "DLXMeProfileCell.h"
#import "DLXMeInfoCell.h"
#import "DLXDefaultCell.h"
#import "DLXStatusManager.h"
#import "DLXStatusUser.h"

@interface DLXMeViewController ()
{
    NSMutableArray *_dataList;
}
@end

extern DLXStatusUser *statusUser;

static NSString *ProfileCellID = @"MeProfileCell";
static NSString *InfoCellID = @"MeInfoCell";
static NSString *cardCellID = @"MeCardCell";

@implementation DLXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigationUI];
    
    //注册cell
    [self.tableView registerClass:[DLXMeProfileCell class] forCellReuseIdentifier:ProfileCellID];
    [self.tableView registerClass:[DLXMeInfoCell class] forCellReuseIdentifier:InfoCellID];
    [self.tableView registerClass:[DLXDefaultCell class] forCellReuseIdentifier:cardCellID];
    //[self getWBUserDataList];

}

//-(void)getWBUserDataList
//{
//  [DLXStatusManager getProfile:^(NSArray *datas) {
//      statusUser = datas[0];
//      NSIndexPath *path1 = [NSIndexPath indexPathForRow:0 inSection:0];
//      NSIndexPath *path2 = [NSIndexPath indexPathForRow:1 inSection:0];
//      [self.tableView reloadRowsAtIndexPaths:@[path1,path2] withRowAnimation:UITableViewRowAnimationFade];
//  } failure:^(NSError *error) {
//      NSLog(@"%@",error );
//  }];
//}

-(void)loadNavigationUI
{
    [self setTitle:@"我"];
    UIBarButtonItem *setting = [UIBarButtonItem ButtonWithNormalTitle:@"设置" target:self action:@selector(tapSetting)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -10;
    self.navigationItem.rightBarButtonItems = @[setting,space];
    
    NSString *strPath = [[NSBundle mainBundle]pathForResource:@"MeDataList" ofType:@"plist"];
    _dataList = [NSMutableArray arrayWithContentsOfFile:strPath];

}
#pragma mark -返回组的行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataList.count+1;
}

#pragma mark -UITableView数据源代理方法，设置组的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    NSArray *arr = _dataList[section-1];
    return arr.count;
    
}

#pragma mark -UITableView数据源代理方法 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row == 0)
        {
            DLXMeProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ProfileCellID];
            [cell setMeProfileWithUser:statusUser];
             return cell;
        }
        if (indexPath.row == 1)
        {
            DLXMeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoCellID];
            [cell setMeInfoWithUser:statusUser];
            return cell;
        }
    }else
    {
        DLXDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cardCellID];
        [cell setDLXCellStyle:DLXDefaultCellStyleImage];
        [cell setCardWithDataList:_dataList indexPath:indexPath];
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 )
    {
        if (indexPath.row==0)
        {
            return kMeProfileCellH;
        }
        else
            return kMeInfoCellH;
    }
    else
        return kDefaultCellH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}
-(void)tapSetting
{

}

@end
