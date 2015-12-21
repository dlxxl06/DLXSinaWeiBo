//
//  DLXSettingTableViewController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXSettingTableViewController.h"
#import "DLXDefaultCell.h"

@interface DLXSettingTableViewController ()
{
    NSArray *_dataList;

}
@end

static NSString *const settingCell = @"settingCell";
@implementation DLXSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[DLXDefaultCell class] forCellReuseIdentifier:settingCell];
    self.title = @"设置";
    NSString *strPath = [[NSBundle mainBundle]pathForResource:@"more" ofType:@"plist"];
    _dataList = [NSArray arrayWithContentsOfFile:strPath];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = _dataList[section];
    return arr.count;
}

#pragma mark -tableView的cell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLXDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}
#pragma mark -tableView的页眉的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}


@end
