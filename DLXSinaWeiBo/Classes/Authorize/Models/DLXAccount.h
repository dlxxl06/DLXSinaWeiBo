//
//  DLXAccount.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLXAccount : NSObject<NSCoding>
@property (nonatomic,strong) NSString *access_token;
@property (nonatomic,strong) NSString *uid;
@end
