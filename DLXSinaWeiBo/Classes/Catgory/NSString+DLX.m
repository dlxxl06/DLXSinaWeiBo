//
//  NSString+DLX.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "NSString+DLX.h"

@implementation NSString (DLX)
-(NSString *)stringAppendString:(NSString *)str
{
    NSString *ext = [self pathExtension];
    NSString *newStr = [self stringByDeletingPathExtension];
    newStr = [newStr stringByAppendingString:str];
    newStr = [newStr stringByAppendingPathExtension:ext];
    return newStr;
}
@end
