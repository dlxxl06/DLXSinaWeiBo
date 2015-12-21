 //
//  DLXHomeViewController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXHomeViewController.h"
#import "UIBarButtonItem+DLX.h"
#import "DLXStatusManager.h"
#import "DLXStatus.h"
#import "DLXStatusUser.h"
#import "UIImageView+WebCache.h"
#import "DLXButton.h"
#import "DLXStatusCellFrame.h"
#import "DLXStatusCell.h"
#import "MJRefresh.h"
#import "UIImage+DLXCompImage.h"
#import "DLXFileManager.h"

static NSString *const statusCellID = @"statusCell";

@interface DLXHomeViewController()
{
    NSMutableArray *_dataList;
}
@end
CGFloat cellWidth=290;

DLXStatusUser *statusUser;

@implementation DLXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *basePath =[[[NSHomeDirectory() stringByDeletingLastPathComponent] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"cache"];
    [[DLXFileManager shareDLXFileManager]setBasePath:basePath];
    
    [self loadHomeUI];
    _dataList = [NSMutableArray array];
    [self.tableView registerClass:[DLXStatusCell class] forCellReuseIdentifier:statusCellID];
    //开始设置cell的样式为无。。。
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setheader];
    [self setfooter];
    [self loadData];
}
-(void)loadData
{
    [DLXStatusManager getProfile:^(NSArray *datas) {
        statusUser = datas[0];
        [self loadTitle];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark -加载主页UI
-(void)loadHomeUI
{
   // self.title = @"首页";
 
    [self loadTitle];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonWithNormalName:@"navigationbar_icon_radar.png" target:self action:@selector(tapRight)];
//    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [progress setLabelText:@"我转，我转，我转转转..."];
//    [progress setDimBackground:YES];
}

-(void)loadTitle
{
       UIBarButtonItem *friend =[UIBarButtonItem buttonWithNormalName:@"navigationbar_friendattention.png" target:self action:@selector(tapLeft)];
    UIBarButtonItem *title = [UIBarButtonItem normalButtonWithTitle:statusUser.screen_name imageName:@"navigationbar_arrow_down.png" target:self action:@selector(tapTitle)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.navigationItem.leftBarButtonItems=@[friend,space,title,space];
}
#pragma mark -上拉刷新
-(void)setheader
{
    __weak __typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DLXLL since_id = _dataList.count?[[_dataList[0] status] statusID]:0;
        [DLXStatusManager getStatusesSince_id:since_id max_id:0 success:^(NSArray *datas) {
            NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:datas.count];
            for (DLXStatus *s in datas)
            {
                DLXStatusCellFrame *frame = [[DLXStatusCellFrame alloc]init];
                [frame setStatus:s];
                [tempArr addObject:frame];
            }
            //保存在本地
            [[DLXFileManager shareDLXFileManager]saveStatusAtPath:@"status" statusLists:datas isLater:NO];
            
            [_dataList insertObjects:tempArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempArr.count)]];
            [weakSelf.tableView reloadData];
            //加载成功后设置cell的样式为singleLine
            [weakSelf.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            [weakSelf.tableView.header endRefreshing];
            [self NewStatusNoficationWithCount:tempArr.count];
        } failure:^(NSError *error) {
            [weakSelf.tableView.header endRefreshing];
        }];
    }];
    //如果本地有缓存则读取缓存，如果没有就请求
    NSArray *localLists = [[DLXFileManager shareDLXFileManager]readStatus:@"/status/statusLists.data"];
    if (localLists.count>0)
    {
        for (DLXStatus *s in localLists)
        {
            DLXStatusCellFrame *frame = [[DLXStatusCellFrame alloc]init];
            [frame setStatus:s];
            [_dataList addObject:frame];
        }
    }
    else
        [self.tableView.header beginRefreshing];
    
}
#pragma mark -下拉加载
-(void)setfooter
{
    __weak __typeof(self)weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        DLXLL max_id = _dataList.count>0?[[[_dataList lastObject] status] statusID]:0;
        [DLXStatusManager getStatusesSince_id:0 max_id:max_id-1 success:^(NSArray *datas) {
            for (DLXStatus *s in datas)
            {
                DLXStatusCellFrame *frame = [[DLXStatusCellFrame alloc]init];
                [frame setStatus:s];
                [_dataList addObject:frame];
            }
            [[DLXFileManager shareDLXFileManager]saveStatusAtPath:@"status" statusLists:datas isLater:YES];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.footer endRefreshing];
        } failure:^(NSError *error) {
            [weakSelf.tableView.footer endRefreshing];
        }];
    }];
    [self.tableView.footer setHidden:YES];
}
#pragma mark -更新微博后提示有多少新微博
-(void)NewStatusNoficationWithCount:(NSInteger)count
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat h = 35;
    [btn setFrame:CGRectMake(0,44-h, self.view.bounds.size.width, h)];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    [btn setEnabled:NO];
    [btn setAdjustsImageWhenDisabled:NO];
    [btn setBackgroundImage:[UIImage imageName:@"timeline_new_status_background.png" x:0.5 y:0.5] forState:UIControlStateNormal];
    NSString *title = count?[NSString stringWithFormat:@"更新了%ld条微博",count]:@"已经是最新的了";
    [btn setTitle:title forState:UIControlStateNormal];
    //动画
    [UIView animateWithDuration:0.5f animations:^{
        [btn setTransform:CGAffineTransformMakeTranslation(0,h)];
        [UIView animateKeyframesWithDuration:.5f delay:1.f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            [btn setTransform:CGAffineTransformIdentity];
        } completion:nil];
    }];
}

#pragma mark -tableView数据源设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
#pragma mark -tableView数据源设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLXStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:statusCellID];
    [cell setPicViewDelegate:_cellPicViewDelegate];
    [cell setStatusCellWithFrame:_dataList[indexPath.section]];
    return cell;
}
#pragma mark -tableView的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dataList[indexPath.section] cellHeight];
}

#pragma mark -左边按钮的事件
-(void)tapLeft
{
}
#pragma mark -右边按钮的事件
-(void)tapRight
{

}
#pragma mark -点击中间按钮
-(void)tapTitle
{
    UIBarButtonItem *item = self.navigationItem.leftBarButtonItems[2];
//    NSLog(@"%@",NSStringFromClass([title.customView class]));
    DLXButton *title = (DLXButton *)item.customView;
    [title setSelected:!title.selected];
    title.selected ?[title setImage:[UIImage imageNamed:@"navigationbar_arrow_up.png"] forState:UIControlStateNormal]:[title setImage:[UIImage imageNamed:@"navigationbar_arrow_down.png"] forState:UIControlStateNormal];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataList.count;
}
#pragma mark -页眉
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}
@end
