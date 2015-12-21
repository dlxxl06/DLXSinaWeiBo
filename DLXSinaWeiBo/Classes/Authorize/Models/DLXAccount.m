//
//  DLXAccount.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXAccount.h"

@implementation DLXAccount
//解档
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}
//归档
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:@"access_token"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}
@end
