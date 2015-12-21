//
//  DLXDisCoverViewController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXDisCoverViewController.h"
#import "DLXSearchView.h"
#import "DLXDefaultCell.h"
#import "DLXDisCoverScrollCell.h"


#define kWIFIH 20
#define kDockH 44
#define kAudioBtnW 30
#define kImageCount 2
static NSString *const disCovDefaultCell = @"disCovDefaultCell";
static NSString *const disCovScrollCell = @"disCovScrollCell";
static NSString *const disCovTopicCell = @"disCovTopicCell";

@interface DLXDisCoverViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    DLXSearchView *_searchView;
    UITableView *_tableView;
    NSArray *_dataList;
    NSMutableArray *_imageArray;
}
@end

@implementation DLXDisCoverViewController
-(void)loadUI
{
    _searchView = [[DLXSearchView alloc]initWithFrame:(CGRect){0,0,self.view.bounds.size.width-kAudioBtnW,44}];
//    [_searchView setBarTintColor:[UIColor whiteColor]];
    [self.view addSubview:_searchView];
    
    
    _tableView = [[UITableView alloc]initWithFrame:(CGRect){0,_searchView.frame.origin.y+_searchView.bounds.size.height,self.view.bounds.size.width,self.view.bounds.size.height-kWIFIH-_searchView.bounds.size.height-kDockH}];
    [self.view addSubview:_tableView];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
}
-(void)loadScrollImage
{
    if (!_imageArray)
    {
        _imageArray = [NSMutableArray arrayWithCapacity:kImageCount];
    }
    for (NSInteger i=1; i<=kImageCount; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",i]];
        [_imageArray addObject:image];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化view
    [self loadUI];
    
    //加载cell数据
    NSString *strPath = [[NSBundle mainBundle]pathForResource:@"DisCoverDataList" ofType:@"plist"];
    _dataList = [NSArray arrayWithContentsOfFile:strPath];
    //注册scrollViewCell
    [_tableView registerClass:[DLXDisCoverScrollCell class] forCellReuseIdentifier:disCovScrollCell];
    //注册defaultCell
    [_tableView registerClass:[DLXDefaultCell class] forCellReuseIdentifier:disCovDefaultCell];
    
    [self loadScrollImage];
}

#pragma mark -table View 的代理方法
#pragma mark tableView每组的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    NSArray *arr = _dataList[section-1];
    return arr.count;
    
}
#pragma mark tableView 的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)//第一组是ScrollView
    {
        DLXDisCoverScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:disCovScrollCell];
        
        [cell setScrollViewCellWithArray:_imageArray];
        return cell;
    }
    else//其他是默认的cell
    {
        DLXDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:disCovDefaultCell];
        [cell setDLXCellStyle:DLXDefaultCellStyleImageNoAccessory];
        [cell setCardWithDataList:_dataList indexPath:indexPath];
        return cell;
//      static  NSString *cellID = @"cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        }
//        [cell.textLabel setText:@"nihao"];
//        return cell;

    }
}
#pragma mark tableView组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataList.count+1;
}
#pragma mark 每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kScrollCellH;
    }
    else
        return kDefaultCellH;
}
#pragma mark 页眉的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}
#pragma mark 页脚的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}


@end
