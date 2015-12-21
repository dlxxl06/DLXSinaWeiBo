//
//  DLXStatusCell.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXStatusCell.h"
#import "DLXStatusCellFrame.h"
#import "DLXStatus.h"
#import "DLXStatusUser.h"
#import "DLXIconView.h"
#import "DLXStatusTextView.h"
#import "DLXRetweetedBar.h"

@interface DLXStatusCell()
{
    //1.用户头像
    DLXIconView *_iconView;
    //2.用户昵称
    UILabel *_screenNameLabel;
    //3.创建时间
    UILabel *_createAtLabel;
    //4.来源
    UILabel *_sourceLabel;
    //5.微博文字
    DLXStatusTextView *_statusTextLabel;
    //6.微博图片
    DLXPicView *_picView;
    //7.转发微博的父控件
    UIView *_retweetedView;
    //8。转发微博的文字和昵称
    DLXStatusTextView *_retweetedTextLabel;
    //9.转发微博的图片
    DLXPicView *_retweetedPicView;
    //10 会员
    UIImageView *_iconMBView;
    //11 评论条
    DLXRetweetedBar *_retweetedBar;
    
}
@end
@implementation DLXStatusCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self loadCellContentUI];
    }
    return self;
}
#pragma mark -加载cell的ContentView
-(void)loadCellContentUI
{
    //1.用户头像
    _iconView = [[DLXIconView alloc]init];
    [self.contentView addSubview:_iconView];
    //2.用户昵称
    _screenNameLabel = [[UILabel alloc]init];
    [_screenNameLabel setFont:Font(kScreenNameSize)];
    [self.contentView addSubview:_screenNameLabel];
    //3.创建时间
    _createAtLabel = [[UILabel alloc]init];
    [_createAtLabel setFont:Font(kCreateAtSize)];
    [self.contentView addSubview:_createAtLabel];
    //4.来源
    _sourceLabel = [[UILabel alloc]init];
    [_sourceLabel setFont:Font(kSourceSize)];
    [_sourceLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_sourceLabel];
    //5.微博文字
    _statusTextLabel = [[DLXStatusTextView alloc]init];
    [_statusTextLabel setFont:Font(kStatusTextSize)];
//    [_statusTextLabel setNumberOfLines:0];
    [self.contentView addSubview:_statusTextLabel];
    [_statusTextLabel setTextColor:[UIColor blackColor]];
    //6.微博图片
    _picView = [[DLXPicView alloc]init];
    [self.contentView addSubview:_picView];
    
    
    //7.转发微博的父控件
    _retweetedView = [[UIView alloc]init];
    [self.contentView addSubview:_retweetedView];
    [_retweetedView setBackgroundColor:RGBA(237, 237, 237, 1)];
    //8。转发微博的文字和昵称
    _retweetedTextLabel = [[DLXStatusTextView alloc]init];
    [_retweetedTextLabel setFont:Font(kRetweetedTextSize)];
//    [_retweetedTextLabel setNumberOfLines:0];
    [_retweetedTextLabel setTextColor:RGBA(40, 40, 40, 1)];
    [_retweetedView addSubview:_retweetedTextLabel];
    //9.转发微博的图片
    _retweetedPicView = [[DLXPicView alloc]init];
    [_retweetedView addSubview:_retweetedPicView];
    //10 会员
    _iconMBView  = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconMBView];
    //11 评论条
    _retweetedBar = [[DLXRetweetedBar alloc]init];
    [self.contentView addSubview:_retweetedBar];
}


-(void)setStatusCellWithFrame:(DLXStatusCellFrame *)frame
{
    
    DLXStatus *s = frame.status;
    [self setStatusContent:s frame:frame];
    if (s.retweeted_status)
    {
        [_retweetedView setHidden:NO];
        [self setRetweetedStatusContent:s.retweeted_status frame:frame];
    }
    else
    {
        [_retweetedView setHidden:YES];
    }
    [_retweetedBar setFrame:frame.retweetedBarFrame];
    [_retweetedBar setReposts:s.reposts_count comments:s.comments_count attitudes:s.attitudes_count];
}
#pragma mark -设置自己的微博
-(void)setStatusContent:(DLXStatus *)s frame:(DLXStatusCellFrame *)frame
{
    //1.用户头像
    [_iconView setFrame:frame.iconFrame];
    [_iconView setUser:s.user type:IconTypeSmall];
    //2.用户昵称
    [_screenNameLabel setFrame:frame.screenNameFrame];
    [_screenNameLabel setText:s.user.screen_name];
    // 10 会员
    [_iconMBView setFrame:frame.iconMBFrame];
    if (s.user.verified_type != kVerifiedTypeNone)
    {
        [_iconMBView setHidden:NO];
        [_iconMBView setImage:[UIImage imageNamed:@"common_icon_membership.png"]];
        [_screenNameLabel setTextColor:RGBA(242, 118, 46, 1)];
    }
    else
    {
        [_screenNameLabel setTextColor:RGBA(36, 36, 36, 1)];
        [_iconMBView setHidden:YES];
    }
    //3.创建时间
    [_createAtLabel setFrame:frame.createAtFrame];
    [_createAtLabel setText:s.created_at];
    [_createAtLabel setTextColor:RGBA(246, 147, 91, 1)];
    //4.来源
    [_sourceLabel setFrame:frame.sourceFrame];
    [_sourceLabel setText:s.source];
    //5.微博文字
    [_statusTextLabel setFrame:frame.statusTextFrame];
//    [_statusTextLabel setText:s.text];
    [_statusTextLabel decorateTextWithString:s.text];
    //6.微博图片
    if (s.pic_urls.count>0)//将图片放在picView中
    {
        [_picView setHidden:NO];
        [_picView setFrame:frame.picFrame];
        
        // -设置图片
        [_picView setImageView:s.pic_urls];
    }
    else
        [_picView setHidden:YES];
}
#pragma mark -设置转发的微博
-(void)setRetweetedStatusContent:(DLXStatus *)s frame:(DLXStatusCellFrame *)frame
{
    //7.转发微博的父控件
    [_retweetedView setFrame:frame.retweetedFrame];
     //8。转发微博的文字和昵称
//    [_retweetedTextLabel setText:[NSString stringWithFormat:@"@%@:%@",s.user.screen_name,s.text]];
    [_retweetedTextLabel setFrame:frame.retweetedTextFrame];
    [_retweetedTextLabel decorateTextWithString:[NSString stringWithFormat:@"@%@: %@",s.user.screen_name,s.text]];
    if (s.pic_urls.count>0)//9.转发微博的图片
    {
        // -设置图片
        [_retweetedPicView setHidden:NO];
         [_retweetedPicView setFrame:frame.retweetedPicFrame];
        [_retweetedPicView setImageView:s.pic_urls];
    }
    else [_retweetedPicView setHidden:YES];
}
-(void)setPicViewDelegate:(id<DLXPicViewDelegate>)picViewDelegate
{
    [_picView setDelegate:picViewDelegate];
    [_retweetedPicView setDelegate:picViewDelegate];
}
@end
