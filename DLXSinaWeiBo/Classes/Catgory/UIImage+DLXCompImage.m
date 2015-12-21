//
//  UIImage+DLXCompImage.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UIImage+DLXCompImage.h"

@implementation UIImage (DLXCompImage)
+(instancetype)imageWithSubImages:(NSString *)image,... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, image);
    NSString *first = image;
    UIImage *comp;
    if (first)
    {
        UIImage *image = [UIImage imageNamed:first] ;
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        // CGContextRef *ctx = UIGraphicsGetCurrentContext();
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        NSString *other;
        while ((other = va_arg(args,NSString *)))
        {
            UIImage *otherImage =[UIImage imageNamed:other];
            [otherImage drawInRect:(CGRect){(image.size.width-otherImage.size.width)*0.5,(image.size.height-otherImage.size.height)*0.5,otherImage.size}];
        }
        va_end(args);

        comp = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return comp;
}
+(instancetype)circleImage:(UIImage *)image
{
    CGFloat radius = image.size.width>image.size.height?image.size.height:image.size.width;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(radius, radius), NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, radius*0.5, radius*0.5, radius*0.5, 0, M_PI*2, 0);
    CGContextFillPath(ctx);
    CGContextClip(ctx);
    [image drawInRect:CGRectMake(0, 0, radius, radius)];
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circle;
}
+(instancetype)redDotImage:(NSInteger)radius
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(radius, radius), NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor redColor] set];
    CGContextAddArc(ctx,radius*0.5, radius*0.5, radius*0.5, 0, M_PI*2, 0);
    CGContextFillPath(ctx);
    return UIGraphicsGetImageFromCurrentImageContext();
}
#pragma mark -拉伸图片
+(instancetype)imageName:(NSString *)image x:(CGFloat)x y:(CGFloat)y
{
    UIImage *newImage = [UIImage imageNamed:image];
    return [ newImage stretchableImageWithLeftCapWidth:newImage.size.width*x topCapHeight:newImage.size.height*y];
}
@end
