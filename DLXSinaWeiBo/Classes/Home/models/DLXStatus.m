//
//  DLXStatus.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXStatus.h"
#import "DLXStatusUser.h"

@implementation DLXStatus
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init])
    {
        _text = dict[@"text"];
       NSString *createStr = dict[@"created_at"];
        _created_at = createStr;
        _statusID = [dict[@"id"] longLongValue];
        self.source = dict[@"source"];
        _thumbnail_pic = dict[@"thumbnail_pic"];
        _bmiddle_pic = dict[@"bmiddle_pic"];
        _original_pic = dict[@"original_pic"];
        _reposts_count = [dict[@"reposts_count"] integerValue];
        _comments_count = [dict[@"comments_count"] integerValue];
        _attitudes_count = [dict[@"attitudes_count"] integerValue];
        _pic_urls = dict[@"pic_urls"];
        //用户
        _user = [[DLXStatusUser alloc]initWithDictionary:dict[@"user"]];
        //转发的微博信息
        NSDictionary *temp = dict[@"retweeted_status"];
        //没有转发的微博则跳过
        if (temp)
        {
             _retweeted_status = [[DLXStatus alloc] initWithDictionary:dict[@"retweeted_status"]];
        }
    }
//   NSMutableAttributedString
    return self;
}

-(void)setSource:(NSString *)source
{// <a href="http://app.weibo.com/t/feed/4fuyNj" rel="nofollow">即刻笔记</a>
    NSInteger begin = [source rangeOfString:@">"].location;
    NSInteger end = [source rangeOfString:@"</"].location;
    if (begin == NSNotFound | end == NSNotFound)
    {
        _source = @"";
    }
    else
    {
        _source = [source substringWithRange:NSMakeRange(begin+1,end-begin-1)];
    }
}
#pragma mark -将时期转换为指定的格式 重写settter方法
-(NSString *)created_at
{
     //Mon Oct 19 09:32:21 +0800 2015
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss zzzz yyyy"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    NSDate *date = [formatter dateFromString:_created_at];
    NSTimeInterval delta = [date timeIntervalSinceNow];
    delta *=-1;//时期转换成正数
    NSString *str = nil;
    if (delta<60)//刚刚
    {
        str = @"刚刚";
    }else if (delta<60*60)//几分钟以前
    {
        str = [NSString stringWithFormat:@"%ld分钟以前",(NSInteger)delta/60];
    
    }else if (delta<60*60*24)//几小时以前
    {
        str = [NSString stringWithFormat:@"%ld小时以前",(NSInteger)delta/(60*60)];
    
    }else
    {
        [formatter setDateFormat:@"mm-dd"];
        str = [formatter stringFromDate:date];
    }
    return str;
}

#pragma mark -本地化微博NSCoding
#pragma mark 归档
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //created_at 	string 	微博创建时间
    [aCoder encodeObject:_created_at forKey:@"created_at"];
    //微博的id
    [aCoder encodeObject:@(_statusID) forKey:@"statusID"];
    //text 	string 	微博信息内容
    [aCoder encodeObject:_text forKey:@"text"];
    //source 	string 	微博来源
    [aCoder encodeObject:_source forKey:@"source"];
    //thumbnail_pic 	string 	缩略图片地址，没有时不返回此字段
    [aCoder encodeObject:_thumbnail_pic forKey:@"thumbnail_pic"];
    //user 	object 	微博作者的用户信息字段
    [aCoder encodeObject:_user forKey:@"user"];
    //retweeted_status 	object 	被转发的原微博信息字段，当该微博为转发微博时返回
    [aCoder encodeObject:_retweeted_status forKey:@"retweeted_status"];
    //reposts_count 	int 	转发数
    [aCoder encodeObject:@(_reposts_count) forKey:@"reposts_count"];
    //comments_count 	int 	评论数
    [aCoder encodeObject:@(_comments_count) forKey:@"comments_count"];
    //attitudes_count 	int 	表态数
    [aCoder encodeObject:@(_attitudes_count) forKey:@"attitudes_count"];
    //pic_urls 	NSArray 	微博配图url。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
    [aCoder encodeObject:_pic_urls forKey:@"pic_urls"];
}
#pragma mark -解档
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        _created_at = [aDecoder decodeObjectForKey:@"created_at"];
        _statusID = [[aDecoder decodeObjectForKey:@"statusID"] integerValue];
        _text = [aDecoder decodeObjectForKey:@"text"];
        _thumbnail_pic = [aDecoder decodeObjectForKey:@"thumbnail_pic"];
        _user = [aDecoder decodeObjectForKey:@"user"];
        _retweeted_status = [aDecoder decodeObjectForKey:@"retweeted_status"];
        _reposts_count = [[aDecoder decodeObjectForKey:@"reposts_count"] integerValue];
         _comments_count = [[aDecoder decodeObjectForKey:@"comments_count"] integerValue];
         _attitudes_count = [[aDecoder decodeObjectForKey:@"attitudes_count"] integerValue];
        _pic_urls  = [aDecoder decodeObjectForKey:@"pic_urls"];
    }
    return self;
}
@end
