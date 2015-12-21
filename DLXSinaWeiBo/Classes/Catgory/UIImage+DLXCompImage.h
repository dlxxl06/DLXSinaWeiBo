//
//  UIImage+DLXCompImage.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DLXCompImage)
+(instancetype)imageWithSubImages:(NSString *)image,... NS_REQUIRES_NIL_TERMINATION;
+(instancetype)circleImage:(UIImage *)image;
+(instancetype)redDotImage:(NSInteger)radius;
+(instancetype)imageName:(NSString *)image x:(CGFloat)x y:(CGFloat)y;
@end
