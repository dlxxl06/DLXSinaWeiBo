//
//  DLXAddViewController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXAddViewController.h"
#import "DLXDockView.h"
#import "DLXComposeItems.h"
#import "UIImage+DLXCompImage.h"
#import "DLXAddDefine.h"

#define kWIFIH 20
#define kItemNum 6
#define kColNum 3

@interface DLXAddViewController ()<DLXDockViewDelegate,DLXComposeItemsDelegate>
{
    DLXDockView *_dockView;
    UIImageView *_imageV;
    DLXComposeItems *_compose;
}
@end

@implementation DLXAddViewController

-(void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    CGRect screen = [[UIScreen mainScreen]applicationFrame];
    _dockView = [[DLXDockView alloc]initWithFrame:(CGRect){0, screen.size.height-kDockHeight,screen.size.width,kDockHeight}];
    [_dockView setDelegate:self];
    [_dockView setDefautItem:0];
    [_dockView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_dockView];
    _compose = [[DLXComposeItems alloc]initWithFrame:CGRectMake(0,self.view.bounds.size.height*0.3, self.view.bounds.size.width,self.view.bounds.size.height*0.5)];
    [_compose setDeletage:self];
    [self.view addSubview:_compose];
}
-(void)dockInit
{
    [_dockView removeAllSubViews];
    [_dockView addItem:COMPOSE_CLOSE selected:nil buttonName:@""];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self dockInit];
    //****************************动画初始化{
    _imageV.alpha = 0;
    [_compose startMoveUpAnimation];
     //****************************动画初始化}
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.view setBackgroundColor:RGBA(200, 200, 200, 1)];
        _imageV.alpha = 1;
    } completion:^(BOOL finished) {
         [self.view setBackgroundColor:RGBA(244, 244, 244, 1)];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:COMPOSE_SHARE];
    image = [UIImage imageWithCGImage:image.CGImage scale:1.5 orientation:UIImageOrientationUp];
    _imageV = [[UIImageView alloc]initWithFrame:(CGRect){CGPointZero,image.size}];
    [_imageV setCenter:CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.2)];
    [_imageV setImage:image];
    [self.view addSubview:_imageV];
    
}

#pragma mark -item的事件方法
#pragma mark 第一组的items的方法
-(void)tapFirstItems:(NSInteger)index
{
    switch (index)
    {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            [_compose startMoveRightAnimation];
            [_dockView removeAllSubViews];
            [self dynamicAddItems];
            break;
        default:
            break;
    }
}

-(void)dynamicAddItems
{
  //  UIImage *back = [UIImage imageWithSubImages:COMPOSE_BUTTON,COMPOSE_RETURN,nil];
  //  UIImage *backS = [UIImage imageWithSubImages:COMPOSE_BUTTON_SELECTED,COMPOSE_RETURN,nil];
   // UIImage *close = [UIImage imageWithSubImages:COMPOSE_BUTTON,COMPOSE_CLOSE,nil];
  //  UIImage *closeS = [UIImage imageWithSubImages:COMPOSE_BUTTON_SELECTED,COMPOSE_CLOSE,nil];
    [_dockView addItem:COMPOSE_RETURN selected:nil buttonName:nil];
    [_dockView addItem:COMPOSE_CLOSE selected:nil buttonName:nil];
}
#pragma mark -第二组items的方法
-(void)tapSecondItems:(NSInteger)index
{
    switch (index) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
}

#pragma mark -composeItems的代理方法
-(void)ComposeItem:(DLXButton *)item page:(NSInteger)page index:(NSInteger)index
{
    if (page==1) {
        [self tapFirstItems:index];
    }
    else
        [self tapSecondItems:index];
    
}

#pragma mark -dockViewItem的代理方法
-(void)dockView:(DLXDockView *)dockView from:(NSInteger)from moveTo:(NSInteger)moveTo
{
    NSInteger count = dockView.subviews.count;
    if (count ==1 )
    {
        [self closeSelf];
    }
    if (count == 2)
    {
        moveTo>0?[self closeSelf]:([_compose startMoveLeftAnimation],[self dockInit]);
    }
}
-(void)closeSelf
{
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [UIView animateWithDuration:0.5f animations:^{
        [self.view setBackgroundColor:[UIColor whiteColor]];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
    [_compose startMoveDownAnimation];
}

@end
