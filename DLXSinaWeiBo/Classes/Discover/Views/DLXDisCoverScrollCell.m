//
//  DLXDisCoverScrollCell.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/15.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXDisCoverScrollCell.h"


#define cellW [UIScreen mainScreen].bounds.size.width

@interface DLXDisCoverScrollCell()<UIScrollViewDelegate>
{

    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    UICollectionView *_collectionView;
    UIImageView *_leftImageV;
    UIImageView *_centerImageV;
    UIImageView *_rightImageV;
    NSArray *_images;
    NSInteger _currentIndex;
    NSInteger _rightImageIndex;
    NSInteger _leftImageIndex;
    NSTimer *_timer;
    NSTimer *_otherTimer;
}
@end
@implementation DLXDisCoverScrollCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:(CGRect){0,0,cellW,kScrollCellH}];
        [self.contentView addSubview:_scrollView];
        [_scrollView setDelegate:self];
        _pageControl = [[UIPageControl alloc]initWithFrame:(CGRect){cellW*0.8,kScrollCellH*0.8,40,0}];
        [self.contentView addSubview:_pageControl];
       _timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
    }
    return  self;
}
#pragma mark -根据数据设置scrollViewCell的内容
-(void)setScrollViewCellWithArray:(NSArray *)images
{
    [self setScrollView:images];
    _images = images;
    [self setPageControll:images.count];
   
}
#pragma mark - 设置scrollView
-(void)setScrollView:(NSArray *)images
{
    CGFloat w= _scrollView.bounds.size.width;
    CGFloat h = _scrollView.bounds.size.height;
    
    [_scrollView setContentSize:CGSizeMake(3*w,h)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setBounces:NO];
    
    //UIScrollView的循环滚动 第一张图片是最后一张图
    _leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
   [_leftImageV setImage:images[images.count-1]];
    [_scrollView addSubview:_leftImageV];
    _centerImageV =[[UIImageView alloc]initWithFrame:CGRectMake(w, 0, w, h)];
    [_centerImageV setImage:images[0]];
    [_scrollView addSubview:_centerImageV];
        //UIScrollView的循环滚动 最后一张图片是第一张图
    _rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(w*2,0, w, h)];
    [_rightImageV setImage:images[1]];
    _rightImageIndex = 1;
    _leftImageIndex = images.count-1;
    [_scrollView addSubview:_rightImageV];
    
    [_scrollView setContentOffset:CGPointMake(w, 0)];
}
#pragma mark -设置pageController
-(void)setPageControll:(NSInteger)pageCount
{
    _currentIndex = 0;
    [_pageControl setNumberOfPages:pageCount];
    [_pageControl setCurrentPage:_currentIndex];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
}
#pragma mark NSTimer的方法
-(void)timerFire
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*2, 0)animated:YES];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer setFireDate:[NSDate distantFuture]];
}
#pragma mark - 当设置 scrollView, 有一个动画效果时触发
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self imageCirculation];
}
#pragma mark - 当 scrollView 结束减速时触发 ( 停止滑动 )
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self imageCirculation];
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.f]];
}
#pragma mark 循环
-(void)imageCirculation
{
    CGFloat offSet =_scrollView.contentOffset.x;
    CGFloat w = _scrollView.frame.size.width;
    //重新加载图片
    if (offSet >w)//向右
    {
        [_leftImageV setImage:_centerImageV.image];
        [_centerImageV setImage:_rightImageV.image];
        _rightImageIndex +=1;
        [_rightImageV setImage:_images[_rightImageIndex%_images.count]];
        _currentIndex =(_currentIndex+1)%_images.count;
    }else if (offSet <w)//向左
    {
        [_rightImageV setImage:_centerImageV.image];
        [_centerImageV setImage:_leftImageV.image];
        _leftImageIndex = (_leftImageIndex+_images.count-1)%_images.count;
        [_leftImageV setImage:_images[_leftImageIndex]];
        _currentIndex =(_currentIndex+_images.count-1)%_images.count;
    }
    [_scrollView setContentOffset:CGPointMake(w, 0)];
    [_pageControl setCurrentPage:_currentIndex];
}
@end
