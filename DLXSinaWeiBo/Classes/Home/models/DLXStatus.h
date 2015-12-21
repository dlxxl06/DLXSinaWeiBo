//
//  DLXStatus.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DLXStatusUser;
@interface DLXStatus : NSObject<NSCoding>

//created_at 	string 	微博创建时间
@property (nonatomic,strong) NSString *created_at;
//微博的id
@property (nonatomic,assign) DLXLL statusID;
//text 	string 	微博信息内容
@property (nonatomic,strong) NSString *text;
//source 	string 	微博来源
@property (nonatomic,strong) NSString *source;
//thumbnail_pic 	string 	缩略图片地址，没有时不返回此字段
@property (nonatomic,strong) NSString *thumbnail_pic;
//bmiddle_pic 	string 	中等尺寸图片地址，没有时不返回此字段
@property (nonatomic,strong) NSString *bmiddle_pic;
//original_pic 	string 	原始图片地址，没有时不返回此字段
@property (nonatomic,strong) NSString *original_pic;
//user 	object 	微博作者的用户信息字段
@property (nonatomic,strong) DLXStatusUser *user;
//retweeted_status 	object 	被转发的原微博信息字段，当该微博为转发微博时返回
@property (nonatomic,strong) DLXStatus *retweeted_status;
//reposts_count 	int 	转发数
@property (nonatomic,assign) NSInteger reposts_count;
//comments_count 	int 	评论数
@property (nonatomic,assign) NSInteger comments_count;
//attitudes_count 	int 	表态数
@property (nonatomic,assign) NSInteger attitudes_count;
//mlevel 	int 	等级
//pic_urls 	NSArray 	微博配图url。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
@property (nonatomic,strong) NSArray *pic_urls;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
