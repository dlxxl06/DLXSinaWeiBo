//
//  DLXAccountManager.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXAccountManager.h"
#define kAccountPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:@"account.data"]

@implementation DLXAccountManager


#pragma mark -单例模式
kSingletion_implementation(DLXAccountManager)


-(instancetype)init
{
    if (self = [super init])
    {
        _currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile: kAccountPath];
    }
    return self;
}
-(void)save:(DLXAccount *)account
{
    _currentAccount = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountPath];

}
@end
