//
//  DLXStatusManager.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXStatusManager.h"
#import "DLXHttpManager.h"
#import "DLXStatus.h"
#import "DLXStatusUser.h"
#import "DLXAccount.h"
#import "DLXAccountManager.h"

typedef void(^RequestSuccussBlock)(id JSON);
typedef void(^RequestFailureBlock)(NSError *error);

@implementation DLXStatusManager

//获取好友微博的地址
NSString *const WBhome = @"2/statuses/home_timeline.json";
NSString *const WBUserShow = @"2/users/show.json";

+(void)requestWBWithPath:(NSString *)path parameters:(NSDictionary *)params success:(RequestSuccussBlock )success failure:(RequestFailureBlock)failure
{
    [DLXHttpManager getRequestWithPath:path parameters:params success:^(id JSON) {
        // NSLog(@"success:%@",JSON[@"statuses"][0]);
        success(JSON);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+(void)getStatusesSince_id:(DLXLL)since_id max_id:(DLXLL)max_id success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure
{
    [self requestWBWithPath:WBhome parameters:@{@"access_token":[[DLXAccountManager shareDLXAccountManager] currentAccount].access_token,
                                                @"since_id":@(since_id),
                                                @"max_id":@(max_id),
                                                @"count":@(30)} success:^(id JSON) {
        if (!success) {
            return ;
        }
        NSArray *dataList = JSON[@"statuses"];
//        NSLog(@"%@",dataList[0]);
        NSMutableArray *datas = [NSMutableArray arrayWithCapacity:dataList.count];
        for (NSDictionary *dict in dataList)
        {
            DLXStatus *status = [[DLXStatus alloc]initWithDictionary:dict];
            [datas addObject:status];
        }
        success(datas);
    } failure:^(NSError *error) {
        if (!failure) {
            return ;
        }
        failure(error);
    }];
}
+(void)getProfile:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure
{
    [self requestWBWithPath:WBUserShow parameters:@{@"access_token":[DLXAccountManager shareDLXAccountManager].currentAccount.access_token,
                                                    @"uid":[DLXAccountManager shareDLXAccountManager].currentAccount.uid
                                                    } success:^(id JSON) {
        if (!success) {
            return ;
        }
                                                       // NSLog(@"%@",JSON);
        NSMutableArray *datas = [NSMutableArray arrayWithCapacity:1];
        DLXStatusUser *user = [[DLXStatusUser alloc]initWithDictionary:(NSDictionary *)JSON];
        [datas addObject:user];
        success(datas);
    } failure:^(NSError *error) {
        if (!failure) {
            return ;
        }
        failure(error);
    }];
}
@end
