//
//  DLXStatusUser.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,VerifiedType)
{
    kVerifiedTypeNone = - 1, // 没有认证
    kVerifiedTypePersonal = 0, // 个人认证
    kVerifiedTypeOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    kVerifiedTypeOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    kVerifiedTypeOrgWebsite = 5, // 网站官方：猫扑
    kVerifiedTypeDaren = 220 // 微博达人
};


@interface DLXStatusUser : NSObject<NSCoding>
//screen_name 	string 	用户昵称
@property (nonatomic,strong) NSString *screen_name;
//url 	string 	用户博客地址
@property (nonatomic,strong) NSString *url;
//profile_image_url 	string 	用户头像地址（中图），50×50像素
@property (nonatomic,strong) NSString *profile_image_url;
//profile_url 	string 	用户的微博统一URL地址
@property (nonatomic,strong) NSString *profile_url;
//followers_count 	int 	粉丝数
@property (nonatomic,assign) NSInteger followers_count;
//friends_count 	int 	关注数
@property (nonatomic,assign) NSInteger friends_count;
//statuses_count 	int 	微博数
@property (nonatomic,assign) NSInteger statuses_count;
//favourites_count 	int 	收藏数
@property (nonatomic,assign) NSInteger favourites_count;
//个性签名
@property (nonatomic,strong) NSString *description;

@property (nonatomic,assign) NSInteger verified_type;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
