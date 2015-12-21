 //
//  DLXHomeViewController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/26.
//  Copyright (c) 2015年 admin. All rights reserved.
//
#import "DLXMainViewController.h"
#import "DLXNavigationController.h"
#import "DLXDockView.h"
#import "DLXHomeViewController.h"
#import "DLXMessageViewController.h"
#import "DLXAddViewController.h"
#import "DLXDisCoverViewController.h"
#import "DLXMeViewController.h"
#import "DLXMainDefine.h"
#import "UIImage+DLXCompImage.h"
#import "DLXPicView.h"
#import "DLXPhotoBrowser.h"

#define kWIFIHeight 20


@interface DLXMainViewController ()<DLXDockViewDelegate,DLXPicViewDelegate>
{
    DLXPhotoBrowser *_PB;
}
@property (nonatomic,strong) DLXDockView *dockView;
@end

@implementation DLXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    //添加dockView
    _dockView = [DLXDockView dockView];
    [_dockView setPatternImage:[UIImage imageNamed:BACKGROUND]];
    [_dockView setDefautItem:1];
    [_dockView setDelegate:self];
    [self.view addSubview:_dockView];
   //添加子控制器
    [self loadChildViewController];
   
    //添加dockItems
    [self loadDockItems];
    _PB = [[DLXPhotoBrowser alloc]initWithFrame:self.view.frame];
}

#pragma mark -视图出现后显示新的消息
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 [_dockView setNewMessages:1 atIndex:0];
 [_dockView setNewMessages:0 atIndex:4];
//    [_dockView setNewMessages:16 atIndex:3];
//    [_dockView setNewMessages:105 atIndex:1];
}

#pragma mark -添加子视图控制器
-(void)loadChildViewController
{
    //首页
    DLXHomeViewController *home = [[DLXHomeViewController alloc]init];
    
    [home setCellPicViewDelegate:self];
    DLXNavigationController *nv1 = [[DLXNavigationController alloc]initWithRootViewController:home];
    [self addChildViewController:nv1];
    //消息
    DLXMessageViewController *msg = [[DLXMessageViewController alloc]init];
    DLXNavigationController *nv2 = [[DLXNavigationController alloc]initWithRootViewController:msg];
    [self addChildViewController:nv2];
    //添加
    DLXAddViewController *add = [[DLXAddViewController alloc]init];
    [self addChildViewController:add];
    //发现
    DLXDisCoverViewController *discover = [[DLXDisCoverViewController alloc]init];
    [self addChildViewController:discover];
    //我
    DLXMeViewController *me = [[DLXMeViewController alloc]init];
    DLXNavigationController *nv3 = [[DLXNavigationController alloc]initWithRootViewController:me];
    [self addChildViewController:nv3];
}
#pragma  mark -加载dockItems
-(void)loadDockItems
{
    [_dockView addItem:HOME selected:HOME_SELECTED buttonName:@"首页"];
    [_dockView addItem:MESSAGE selected:MESSAGE_SELECTED buttonName:@"消息"];
    //[_dockView addItem:ADD selected:nil buttonName:@""];
    UIImage *add =[UIImage imageWithSubImages:ADDBACK,ADDADD,nil];
    [_dockView addItem:add selected:nil buttonName:@""];
    [_dockView addItem:DISCOVER selected:DISCOVER_SELECTED buttonName:@"发现"];
    [_dockView addItem:PROFILE selected:PROFILE_SELECTED buttonName:@"我"];
    
    
}
#pragma mark -dockView的代理方法
-(void)dockView:(DLXDockView *)dockView from:(NSInteger)from moveTo:(NSInteger)moveTo
{
    UIViewController *toVC = self.childViewControllers[moveTo];
    UIViewController *fromVC = self.childViewControllers[from];
    
    if (moveTo == 2) {[toVC.view setFrame:(CGRect){0,kWIFIHeight,self.view.bounds.size.width,self.view.bounds.size.height-kWIFIHeight}];}
    else
    {
        [fromVC.view removeFromSuperview];
        [toVC.view setFrame:(CGRect){0,kWIFIHeight,self.view.bounds.size.width,self.view.bounds.size.height-kDockHeight-kWIFIHeight}];
    }
    [_PB removeFromSuperview];
    [self.view addSubview:toVC.view];
    
}
#pragma mark -图片点击的代理方法
-(void)DLXPicView:(DLXPicView *)picView pic_urls:(NSArray *)pic_urls index:(id)index
{
    [self.view addSubview:_PB];
    [_PB setHidden:YES];[_PB setScrollViewHidden:YES];
     [_PB setBackgroundColor:[UIColor clearColor]];
    NSInteger tapIndex = ((NSNumber *)index).integerValue;
    //    NSLog(@"%ld",tapIndex);
    [_PB setPic_urls:pic_urls];
    [_PB setCurrentIndex:tapIndex];
    for (UIImageView *imageV in picView.subviews)
    {
        if (imageV.tag == tapIndex)
        {
            CGRect rect =[imageV convertRect:imageV.bounds toView:self.view];
            UIImageView *tempImageV = [[UIImageView alloc]initWithFrame:rect];
            [tempImageV setImage:imageV.image];
            
            [tempImageV setContentMode:picView.sourceContentMode];
            [self.view addSubview:tempImageV];
            [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:.52f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [tempImageV setContentMode:_PB.BrowerContentMode];
                [tempImageV setFrame:(CGRect){0,kLabelH+20,_PB.frame.size.width,_PB.frame.size.height-kLabelH}];
                [_PB setHidden:NO];
                [_PB setBackgroundColor:[UIColor blackColor]];
            } completion:^(BOOL finished){
                [_PB setScrollViewHidden:NO];
                [tempImageV removeFromSuperview];
               
            }];
            break;
        }
    }
    [self exitBrowseImage:picView];
}
#pragma mark -退出图片浏览器
-(void)exitBrowseImage:(DLXPicView *)picView;
{
    __block DLXPhotoBrowser *PBSelf = _PB;
    __weak __typeof(self) Self = self;
    [_PB setBackBlock:^(NSInteger currentIndex){
        for (UIImageView *imageV in picView.subviews)
        {
            if (imageV.tag == currentIndex)
            {
               
                CGRect rect =[imageV convertRect:imageV.bounds toView:Self.view];
                //                NSLog(@"%@",NSStringFromCGRect(rect));
                UIImageView *tempImageV = [[UIImageView alloc]initWithFrame:(CGRect){0,kLabelH+20,PBSelf.frame.size.width,PBSelf.frame.size.height-kLabelH}];
                [tempImageV setImage:imageV.image];
                
                [tempImageV setContentMode:PBSelf.BrowerContentMode];
                
                if (rect.origin.y  <= Self.view.frame.size.height-kWIFIHeight-kDockHeight)
                {
                    
                    [imageV setHidden:YES];
                     [Self.view addSubview:tempImageV];
                    
                    [PBSelf setHidden:YES];
                    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:.6f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                        if(rect.origin.y + rect.size.height > Self.view.frame.size.height - kWIFIHeight-kDockHeight)
//                            [Self.view sendSubviewToBack:Self.dockView];//有动画会阻止 不可用
                        [tempImageV setFrame:rect];
                        [tempImageV setContentMode:picView.sourceContentMode];
                    } completion:^(BOOL finished){
                        [imageV setHidden:NO];
                        [tempImageV removeFromSuperview];
                    }];
                }else
                {
                    [PBSelf setHidden:YES];
                } 
                break;
            }
        }
    }];

}

@end
