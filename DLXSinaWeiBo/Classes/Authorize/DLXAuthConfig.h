//
//  DLXAuthConfig.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#ifndef DLXSinaWeiBo_DLXAuthConfig_h
#define DLXSinaWeiBo_DLXAuthConfig_h

//微博地址
NSString *const WBBaseUrl = @"https://api.weibo.com";
//appKey
NSString *const WBAppKey = @"229124078";
//授权回调地址
NSString *const WBRedirect_uri =@"http://weibo.com/u/2966838322/home?wvr=5";
//申请授权
NSString *const WBAuth2 = @"oauth2/authorize";

//grant_type
NSString *const WBGrant_type =@"authorization_code";
//获取授权
NSString *const WBAccess_token =@"oauth2/access_token";
//client_secret
NSString *const WBClient_secret = @"09a547e3d1d03eb0a885b2d7f8ed2805";



#endif
