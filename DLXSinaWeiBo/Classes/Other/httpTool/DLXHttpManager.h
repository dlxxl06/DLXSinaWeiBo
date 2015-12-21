//
//  DLXHttpManager.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/9.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpSuccessBlock)(id JSON);
typedef void(^HttpFailureBlock)(NSError *error);

@interface DLXHttpManager : NSObject

+(void)postRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+(void)getRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
@end
