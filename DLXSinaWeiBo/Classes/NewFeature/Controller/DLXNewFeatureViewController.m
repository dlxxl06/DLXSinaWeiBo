//
//  DLXNewFeatureViewController.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/26.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXNewFeatureViewController.h"
#import "DLXAuthViewController.h"
#import "MBProgressHUD.h"
#define kImageCount 4

//新特性
#define new_feature_() @"new_feature_%ld.png"
//pageControl
#define NEW_DOT @"new_dot.png"
#define NEW_DOT_BLUE @"new_dot_blue.png"

#define ENTER_WEIBO @"new_feature_button.png"
#define ENTER_WEIBO_H @"new_feature_button_highlighted.png"

#define SHARE_TRUE @"new_feature_share_true.png"
#define SHARE_FALSE @"new_feature_share_false.png"


@interface DLXNewFeatureViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}
@end

@implementation DLXNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建_scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:(CGRect){0,0,self.view.bounds.size.width,self.view.bounds.size.height}];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    [_scrollView setDelegate:self];
    
    //添加pageControl
    _pageControl=(
                  {
                      UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:(CGRect){CGPointZero,CGSizeMake(180, 36)}];
                      [pageControl setCenter:(CGPoint){self.view.bounds.size.width*0.5,self.view.bounds.size.height*0.95}];
                      [pageControl setNumberOfPages:kImageCount];
                      [pageControl setCurrentPage:0];
                      [pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:NEW_DOT]]];
                      [pageControl setPageIndicatorTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:NEW_DOT_BLUE]]];
                      [self.view addSubview:pageControl];
                      pageControl;
                  });
    
    //修改_scrollView的属性
    [self loadScrollView];
    
    //加载图片
    [self loadScrollViewImages];
    
    
}

#pragma mark -scrollView的属性修改
-(void)loadScrollView
{
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width*kImageCount, _scrollView.bounds.size.height)];
    [_scrollView setBounces:NO];

}
#pragma mark -_scrollView加载图片
-(void)loadScrollViewImages
{
    CGFloat w = _scrollView.bounds.size.width;
    CGFloat h = _scrollView.bounds.size.height;
    for (NSInteger i=1; i<=kImageCount; i++)
    {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((i-1)*w,0, w, h)];
        [imageV setImage:[UIImage imageNamed:[NSString stringWithFormat: new_feature_(),i]]];
        [_scrollView addSubview:imageV];
        
        //最后一张图片添加按钮
        if(i==kImageCount)
        {
            [imageV setUserInteractionEnabled:YES];
            
            [self loadEnterWeiboAtImageView:imageV];
        }
    }
}

#pragma mark -加载进入微博的按钮
-(void)loadEnterWeiboAtImageView:(UIImageView *)imageV
{

    UIImage *enterImg = [UIImage imageNamed:ENTER_WEIBO];
    UIImage *enterImg_H = [UIImage imageNamed:ENTER_WEIBO_H];
    
    UIImage *share_true_img = [UIImage imageNamed:SHARE_TRUE];
    UIImage *share_false_img = [UIImage imageNamed:SHARE_FALSE];
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [enterBtn setFrame:(CGRect){CGPointZero,enterImg.size}];
    [enterBtn setCenter:CGPointMake(imageV.bounds.size.width*0.5,_pageControl.frame.origin.y-40)];
    
    [enterBtn setImage:enterImg forState:UIControlStateNormal];
    [enterBtn setImage:enterImg_H forState:UIControlStateHighlighted];
    [imageV addSubview:enterBtn];
    [enterBtn addTarget:self action:@selector(tapEnter:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setFrame:(CGRect){CGPointZero,share_false_img.size}];
    [shareBtn setCenter:CGPointMake(imageV.bounds.size.width*0.5, enterBtn.frame.origin.y-40)];
    
    [shareBtn setImage:share_false_img forState:UIControlStateNormal];
    [shareBtn setImage:share_true_img forState:UIControlStateSelected];
    [imageV addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(tapShare:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setSelected:YES];
}
#pragma mark -私有方法
#pragma mark 进入微博按钮的事件
-(void)tapEnter:(UIButton *)sender
{
    [self.view.window setRootViewController:[[DLXAuthViewController alloc]init]];
}
#pragma mark 分享按钮的事件
-(void)tapShare:(UIButton *)sender
{
    [sender setSelected:!sender.isSelected];
}

#pragma mark -scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat w = scrollView.bounds.size.width;
    [_pageControl setCurrentPage:scrollView.contentOffset.x/w];
    
}


@end
