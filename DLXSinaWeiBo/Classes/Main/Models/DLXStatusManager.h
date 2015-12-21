//
//  DLXStatusManager.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^StatusSuccessBlock)(NSArray *datas);
typedef void(^StatusFailureBlock)(NSError *error);



@interface DLXStatusManager : NSObject
+(void)getStatusesSince_id:(DLXLL)since_id max_id:(DLXLL)max_id success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;
+(void)getProfile:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;
@end
