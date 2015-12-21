//
//  DLXFileManager.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/22.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLXFileManager : NSObject
@property (nonatomic,strong) NSString *basePath;
kSingleton_interface(DLXFileManager);
#pragma mark 保存微博数据 
-(void)saveStatusAtPath:(NSString *)subPath statusLists:(NSArray *)statusLists isLater:(BOOL)later;
#pragma mark -读取本地微博数据
-(NSArray *)readStatus:(NSString *)path;

@end
