//
//  DLXFileManager.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/22.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXFileManager.h"
#import "DLXStatus.h"
@interface DLXFileManager()
{
    NSString *_statusPath;
}
@end
@implementation DLXFileManager
kSingletion_implementation(DLXFileManager);
#pragma mark 保存微博数据
-(void)saveStatusAtPath:(NSString *)subPath statusLists:(NSArray *)statusLists isLater:(BOOL)later
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool
        {
            if (!_statusPath)
            {
                NSString *path = [_basePath stringByAppendingPathComponent:subPath];
                if (![[NSFileManager defaultManager]fileExistsAtPath:path])
                {
                    [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                }
                _statusPath = [path stringByAppendingPathComponent:@"statusLists.data"];
            }
            if (statusLists.count>0)
            {
                 NSArray *oldLists = [NSKeyedUnarchiver unarchiveObjectWithFile:_statusPath];
                NSMutableArray *newLists = [NSMutableArray arrayWithArray:oldLists];
                later?[newLists addObjectsFromArray:statusLists]:[newLists insertObjects:statusLists atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statusLists.count)]];
                [NSKeyedArchiver archiveRootObject:newLists toFile:_statusPath];
            }
          
        
        }
    });
    
}
#pragma mark -读取本地微博数据
-(NSArray *)readStatus:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[_basePath stringByAppendingString:path]];
}
@end
