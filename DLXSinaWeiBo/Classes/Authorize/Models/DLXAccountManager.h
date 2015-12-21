//
//  DLXAccountManager.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DLXAccount;
@interface DLXAccountManager : NSObject
@property (nonatomic,readonly) DLXAccount *currentAccount;

#pragma mark -保存帐号
-(void)save:(DLXAccount *)account;

kSingleton_interface(DLXAccountManager);
@end
