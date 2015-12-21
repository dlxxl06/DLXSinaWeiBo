//
//  DLXPhotoBrowser.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/22.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

#define kLabelW 30
static char const kImageBackKey = '2';
@interface DLXPhotoBrowser()<UIScrollViewDelegate>
{
    UILabel *_numLabel;
    UIScrollView *_scrollView;
    PhotoBrowerBlock _backBlock;
}
@end
@implementation DLXPhotoBrowser

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:(CGRect){0,kLabelH,frame.size.width,frame.size.height}];
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake((frame.size.width-kLabelW)*0.5,0,kLabelW, kLabelH)];
        [_numLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:_numLabel];
        [self addSubview:_scrollView];
        [_scrollView setBounces:NO];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _BrowerContentMode = UIViewContentModeScaleAspectFit;
        [_scrollView setPagingEnabled:YES];
        _scrollViewHidden  = YES;
        [_scrollView setHidden:_scrollViewHidden];
        [_scrollView setDelegate:self];
    }
    return self;
}
-(void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    for (UIImageView *imageV in _scrollView.subviews)
    {
        [imageV removeFromSuperview];
    }
    [self setScrollViewContent:pic_urls];
    

}
-(void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self showCurrentImage:currentIndex];
    [_numLabel setText:[NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,_pic_urls.count]];
}
-(void)setScrollViewContent:(NSArray *)pic_urls
{
    
    CGFloat w= _scrollView.frame.size.width;
    CGFloat h = _scrollView.frame.size.height;
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [_scrollView setContentSize:CGSizeMake(w*pic_urls.count,h)];
    for (NSInteger i=0; i<pic_urls.count; i++)
    {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:(CGRect){i*w,0,w,h}];
        [imageV setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
        objc_setAssociatedObject(tapGes, &kImageBackKey, @(i), OBJC_ASSOCIATION_ASSIGN);
        [imageV addGestureRecognizer:tapGes];
        [imageV setContentMode:_BrowerContentMode];
        UIImage *image = [imageCache imageFromDiskCacheForKey:pic_urls[i][@"thumbnail_pic"]];
        if (image)//本地有图片
        {
            [imageV setImage:image];
//            NSLog(@"%@",NSStringFromCGSize(image.size));
        }
        else
        {
            [imageV sd_setImageWithURL:[NSURL URLWithString:pic_urls[i][@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"image_placeHolder.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [imageCache storeImage:imageV.image forKey:pic_urls[i][@"thumbnail_pic"]];
            }];
        }
        [_scrollView addSubview:imageV];
    }
}
#pragma mark -显示当前页
-(void)showCurrentImage:(NSInteger )index
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*index,0) animated:NO];
}
#pragma mark -UIScrollView的代理 方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width+1;
    [_numLabel setText:[NSString stringWithFormat:@"%ld/%ld",page,_pic_urls.count]];
}
-(void)setBackBlock:(PhotoBrowerBlock)backBlock
{
    _backBlock = backBlock;
}
-(void)back:(UITapGestureRecognizer *)sender
{
    NSNumber *num = objc_getAssociatedObject(sender, &kImageBackKey);
    _backBlock([num integerValue]);
}
-(void)setScrollViewHidden:(BOOL)scrollViewHidden
{
    _scrollViewHidden = scrollViewHidden;
    [_scrollView setHidden:_scrollViewHidden];
}
@end
