//
//  DLXStatusUser.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXStatusUser.h"

@implementation DLXStatusUser
@synthesize  description =_description;
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init])
    {
        _screen_name = dict[@"screen_name"];
        _url = dict[@"url"];
        _profile_image_url = dict[@"profile_image_url"];
        _profile_url = dict[@"profile_url"];
        _followers_count = [dict[@"followers_count"] integerValue];
        _friends_count = [dict[@"friends_count"] integerValue];
        _statuses_count = [dict[@"statuses_count"] integerValue];
        _favourites_count = [dict[@"favourites_count"] integerValue];
        _description = dict[@"description"];
        _verified_type = [dict[@"verified_type"] integerValue];
    }
    return self;
}
#pragma mark -NSCoding 协议
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //screen_name 	string 	用户昵称
    [aCoder encodeObject:_screen_name forKey:@"screen_name"];
    //url 	string 	用户博客地址
    [aCoder encodeObject:_url forKey:@"url"];
    //profile_image_url 	string 	用户头像地址（中图），50×50像素
    [aCoder encodeObject:_profile_image_url forKey:@"profile_image_url"];
    //profile_url 	string 	用户的微博统一URL地址
    [aCoder encodeObject:_profile_url forKey:@"profile_ur"];
    //followers_count 	int 	粉丝数
    [aCoder encodeObject:@(_followers_count) forKey:@"followers_count"];
    //friends_count 	int 	关注数
    [aCoder encodeObject:@(_friends_count) forKey:@"friends_count"];
    //statuses_count 	int 	微博数
    [aCoder encodeObject:@(_statuses_count) forKey:@"statuses_count"];
    //favourites_count 	int 	收藏数
    [aCoder encodeObject:@(_favourites_count) forKey:@"favourites_count"];
    //个性签名
    [aCoder encodeObject:_description forKey:@"description"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        _screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
        _url = [aDecoder decodeObjectForKey:@"url"];
        _profile_image_url = [aDecoder decodeObjectForKey:@"profile_image_url"];
        _profile_url = [aDecoder decodeObjectForKey:@"profile_url"];
        _followers_count = [[aDecoder decodeObjectForKey:@"followers_count"]integerValue];
        _friends_count = [[aDecoder decodeObjectForKey:@"friends_count"]integerValue];
        _statuses_count = [[aDecoder decodeObjectForKey:@"statuses_count"]integerValue];
        _favourites_count = [[aDecoder decodeObjectForKey:@"favourites_count"]integerValue];
        _description = [aDecoder decodeObjectForKey:@"description"];
    }
    return self;
}
@end
