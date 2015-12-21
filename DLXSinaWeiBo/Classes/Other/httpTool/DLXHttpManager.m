//
//  DLXHttpManager.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/9.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXHttpManager.h"
#import "AFNetworking.h"
#import "DLXAccount.h"
#import "DLXAccountManager.h"

@implementation DLXHttpManager

 NSString *const BaseUrl = @"https://api.weibo.com";

#pragma mark -通用请求方法
+(void)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
   
    AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:BaseUrl]];
    
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    NSString *access_token = [[DLXAccountManager shareDLXAccountManager] currentAccount].access_token;
    if (parameters!=nil)
    {
        [mdict setDictionary:parameters];
    }
    else
     (access_token==nil?nil:access_token)? [mdict setObject:access_token forKey:@"access_token"]:nil;
    
    NSURLRequest *req = [client requestWithMethod:method path:path parameters:mdict];
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:req success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (!success) {
            return ;
        }
        success(JSON);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (!failure) {
            return ;
        }
        failure(error);
    }];
    [op start];
    
}
#pragma mark -post请求
+(void)postRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    
    [self requestWithMethod:@"POST" path:path parameters:parameters success:^(id JSON) {
        if (!success) {
            return ;
        }
        success(JSON);
    } failure:^(NSError *error) {
        if (!failure) {
            return ;
        }
        failure(error);
    }];
}
+(void)getRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithMethod:@"GET" path:path parameters:parameters success:^(id JSON) {
        if (!success) {
            return ;
        }
        success(JSON);
    } failure:^(NSError *error) {
        if (!failure) {
            return ;
        }
        failure(error);
    }];

}
@end
