//
//  DLXPicView.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/22.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXPicView.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

#define kRowNum 3
#define kPicImageSpace 5
#define kPicImageW 115
#define kPicImageH 115

static char const tapIndexKey = '\0';
static char const pic_urlsKey = '1';

//@interface DLXPicView()
//@property (nonatomic,strong) UITapGestureRecognizer *tapGes;
//@end
@implementation DLXPicView
-(void)setImageView:(NSArray *)pic_urls
{
    //如果原来的图片个数小于cout则添加少于的个数
    for(NSInteger i = self.subviews.count;i<pic_urls.count;i++)
    {
        NSInteger row = i/kRowNum;
        NSInteger col = i%kRowNum;
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(col>0?col*(kPicImageW+kPicImageSpace):0, i>=3?row*(kPicImageH+kPicImageSpace):0, kPicImageW, kPicImageH)];
        [imageV setUserInteractionEnabled:YES];
        [imageV setTag:i];
        [self addSubview:imageV];
    }
    //重用_retweetedPicView中的imageView;
    for (NSInteger i=0; i<self.subviews.count;i++)
    {
        UIImageView *imageV =self.subviews[i];
        if (i<pic_urls.count)
        {
            [imageV setHidden:NO];
            if (pic_urls.count==1)
            {
                _sourceContentMode =UIViewContentModeCenter;
            }
            else
            {
                _sourceContentMode = UIViewContentModeScaleToFill;
               
            }
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            objc_setAssociatedObject(tapGes, &tapIndexKey,@(i), OBJC_ASSOCIATION_ASSIGN);
            objc_setAssociatedObject(tapGes, &pic_urlsKey, pic_urls, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [imageV addGestureRecognizer:tapGes];
             [imageV setContentMode:_sourceContentMode];
            UIImage *image;
            SDImageCache *imageCache= [SDImageCache sharedImageCache];
            
            image= [imageCache imageFromDiskCacheForKey:pic_urls[i][@"thumbnail_pic"]];
            if (!image)
            {
                [imageV sd_setImageWithURL:[NSURL URLWithString:pic_urls[i][@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"image_placeHolder.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [imageCache storeImage:imageV.image forKey:pic_urls[i][@"thumbnail_pic"]];
                }];
            }
            else
                [imageV setImage:image];
        }
        else
            [imageV setHidden:YES];
    }

}

#pragma mark -图片点击手势的方法
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    [_delegate DLXPicView:self pic_urls:objc_getAssociatedObject(sender, &pic_urlsKey) index:objc_getAssociatedObject(sender, &tapIndexKey)];
//    NSLog(@"%@",objc_getAssociatedObject(sender, &pic_urlsKey));
}
@end
