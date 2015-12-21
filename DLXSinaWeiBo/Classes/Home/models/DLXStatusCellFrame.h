//
//  DLXStatusCellFrame.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSpaceInterval 10
#define kScreenNameSize 17.f
#define kCreateAtSize 13.f
#define kSourceSize 13.f
#define kStatusTextSize 15.f
#define kRetweetedTextSize 14.f

#define kRowNum 3
#define kPicImageSpace 5
#define kPicImageW 115
#define kPicImageH 115
#define kIconMBW 14
#define kIconMBH kIconMBW

#define kRetweetedBarH 40
@class DLXStatus;
@interface DLXStatusCellFrame : NSObject
#pragma mark -微博
@property (nonatomic,readonly)CGFloat cellHeight;

@property (nonatomic,strong) DLXStatus *status;
//1.用户头像
@property (nonatomic,readonly) CGRect iconFrame;
//2.用户昵称
@property (nonatomic,readonly) CGRect screenNameFrame;
//3.创建时间
@property (nonatomic,readonly) CGRect createAtFrame;
//4.来源
@property (nonatomic,readonly) CGRect sourceFrame;
//5.微博文字
@property (nonatomic,readonly) CGRect statusTextFrame;
//6.微博图片
@property (nonatomic,readonly) CGRect picFrame;
//7.转发微博的父控件
@property (nonatomic,readonly) CGRect retweetedFrame;
//8。转发微博的文字和昵称
@property (nonatomic,readonly) CGRect retweetedTextFrame;
//9.转发微博的图片
@property (nonatomic,readonly) CGRect retweetedPicFrame;
//10 .会员
@property (nonatomic,readonly) CGRect iconMBFrame;
//11. 评论条
@property (nonatomic,readonly) CGRect retweetedBarFrame;

@end
