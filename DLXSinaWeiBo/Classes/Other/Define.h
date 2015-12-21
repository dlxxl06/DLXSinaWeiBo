//
//  Define.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#ifndef DLXSinaWeiBo_Define_h
#define DLXSinaWeiBo_Define_h

#import <Availability.h>
#define kSingleton_interface(className) +(instancetype)share##className

#define kSingletion_implementation(className) \
\
static className *instanceObj=nil;\
\
+(instancetype)share##className\
{\
if (!instanceObj) {\
instanceObj = [[self alloc]init];\
}\
return instanceObj;\
}\
\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instanceObj = [super allocWithZone:zone];\
});\
return instanceObj;\
}

#define Font(size)  [UIFont systemFontOfSize:size]

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    #define TEXTSIZE(text,fontSize) [text length]>0?[text sizeWithAttributes:@{NSFontAttributeName:Font(fontSize)}]:CGSizeZero;
#else
    #define TEXTSIZE(text,fontSize)  [text length]>0?[text sizeWithFont:Font(fontSize)]:CGSizeZero;
#endif


typedef long long DLXLL;
#define IMAGE_PLACEHOLDER @"image_placeHolder.png"


#endif
