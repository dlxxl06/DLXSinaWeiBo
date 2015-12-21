//
//  DLXRetweetedBar.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXRetweetedBar.h"
@interface DLXRetweetedBar()
{
    UIButton *_repost;//转发
    UIButton *_comment;//评论
    UIButton *_attitude;//点赞
    UIImageView *_line1View;
    UIImageView *_line2View;
}
@end
#define kTitleFontSize 14.f
@implementation DLXRetweetedBar
-(instancetype)init
{
    if (self = [super init])
    {
        _repost = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repost setTag:0];
        _comment = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repost setTag:1];
        _attitude = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repost setTitleColor:RGBA(128, 128, 128, 1) forState:UIControlStateNormal];
        [_attitude setTag:2];
        [_comment setTitleColor:RGBA(128, 128, 128, 1) forState:UIControlStateNormal];
        [_attitude setTitleColor:RGBA(128, 128, 128, 1) forState:UIControlStateNormal];
        [_repost.titleLabel setFont:Font(kTitleFontSize)];
        [_repost.titleLabel setTextAlignment:NSTextAlignmentCenter];
         [_comment.titleLabel setFont:Font(kTitleFontSize)];
        [_comment.titleLabel setTextAlignment:NSTextAlignmentCenter];
         [_attitude.titleLabel setFont:Font(kTitleFontSize)];
        [_attitude.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_repost setImage:[UIImage imageNamed:@"statusdetail_icon_retweet.png"] forState:UIControlStateNormal];
//        [_repost setImage:[UIImage imageNamed:@"statusdetail_comment_icon_like_highlighted.png"] forState:UIControlStateSelected];
        [_comment setImage:[UIImage imageNamed:@"statusdetail_icon_comment.png"] forState:UIControlStateNormal];
        [_attitude setImage:[UIImage imageNamed:@"statusdetail_comment_icon_like.png"] forState:UIControlStateNormal];
        [self addSubview:_repost];
        [self addSubview:_comment];
        [self addSubview:_attitude];
        [_repost addTarget:self action:@selector(tapBar:) forControlEvents:UIControlEventTouchUpInside];
        
        _line1View = [[UIImageView alloc]init];
        [self addSubview:_line1View];
        [_line1View setImage:[UIImage imageNamed:@"statusdetail_comment_line.png"]];
        _line2View = [[UIImageView alloc]init];
        [_line2View setImage:[UIImage imageNamed:@"statusdetail_comment_line.png"]];
        
        [self addSubview:_line2View];
        
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat w = frame.size.width/3.0f;
    CGFloat h = frame.size.height;
    [_repost setFrame:(CGRect){0,0,w,h}];
    [_comment setFrame:(CGRect){CGRectGetMaxX(_repost.frame),0,w,h}];
    [_attitude setFrame:(CGRect){CGRectGetMaxX(_comment.frame),0,w,h}];
    [_line1View setFrame:(CGRect){CGRectGetMaxX(_repost.frame),7,2,30}];
    [_line2View setFrame:(CGRect){CGRectGetMaxX(_comment.frame),7,2,30}];
}
-(void)setReposts:(NSInteger)reposts comments:(NSInteger)comments attitudes:(NSInteger)attitudes
{
    [_repost setTitle:reposts>0?[NSString stringWithFormat:@"%ld",reposts]:@"转发" forState:UIControlStateNormal];
    [_comment setTitle:comments>0?[NSString stringWithFormat:@"%ld",comments]:@"评论" forState:UIControlStateNormal];
    [_attitude setTitle:attitudes>0?[NSString stringWithFormat:@"%ld",attitudes]:@"点赞" forState:UIControlStateNormal];

}
-(void)tapBar:(UIButton *)btn
{
    [_delegate DLXRetweetedButton:btn index:btn.tag];
}
@end
