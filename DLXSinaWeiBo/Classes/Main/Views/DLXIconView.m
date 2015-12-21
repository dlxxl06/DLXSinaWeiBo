//
//  DLXIconView.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXIconView.h"
#import "DLXStatusUser.h"
#import "UIImageView+WebCache.h"

#define kIconSmallW 34
#define kIconSmallH kIconSmallW

#define kIconDefaultW 50
#define kIconDefaultH kIconDefaultW

#define kIconBigW 85
#define kIconBigH kIconBigW

#define kVerifyW 18
#define kVerifyH 18

@interface DLXIconView()
{
    UIImageView *_iconImageView;
    UIImageView *_verifyImageView;
    UIImage *_iconImage;
}
@end
@implementation DLXIconView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _iconImageView = [[UIImageView alloc]init];
        [self addSubview:_iconImageView];
        _verifyImageView = [[UIImageView alloc]init];
        [self addSubview:_verifyImageView];
    }
    return self;
}
#pragma mark -重写Type setter方法
-(void)setType:(IconType)type
{
    _type = type;
    CGSize size;
    switch (_type)
    {
        case IconTypeSmall:
            size = (CGSize){kIconSmallW,kIconSmallH};
            _iconImage = [UIImage imageNamed:@"avatar_default_small.png"];
            break;
        case IconTypeDefault:
             size = (CGSize){kIconDefaultW,kIconDefaultH};
             _iconImage = [UIImage imageNamed:@"avatar_default.png"];
            break;
        case IconTypeBig:
             size = (CGSize){kIconBigW,kIconBigH};
             _iconImage = [UIImage imageNamed:@"avatar_default_big.png"];
            break;
        default:
            break;
    }
    [_iconImageView setFrame:(CGRect){CGPointZero,size}];
    [_verifyImageView setBounds:(CGRect){CGPointZero,kVerifyW,kVerifyH}];
    [_verifyImageView setCenter:CGPointMake(size.width,size.height)];
}
#pragma mark -重写user的setter方法
-(void)setUser:(DLXStatusUser *)user
{
    _user = user;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:_iconImage options:SDWebImageRetryFailed | SDWebImageLowPriority ];
    
    NSString *verifyName = nil;
    switch (_user.verified_type)
    {
        case kVerifiedTypeNone:
            [_verifyImageView setHidden:YES];
            break;
        case kVerifiedTypeDaren:
           verifyName = @"avatar_grassroot.png";
            break;
        case kVerifiedTypePersonal:
            verifyName = @"avatar_vip.png";
            break;
        default:
            
             verifyName = @"avatar_enterprise_vip.png";
            break;
    }
    if (verifyName)
    {
        [_verifyImageView setHidden:NO];
        [_verifyImageView setImage:[UIImage imageNamed:verifyName]];
    }
}
#pragma mark -在类空间中获得type类型的size
+(CGSize)iconViewSizeWithType:(IconType)type
{
    CGSize iconSize;
    switch (type)
    {
        case IconTypeSmall:
            iconSize = (CGSize){kIconSmallW,kIconSmallH};
            break;
        case IconTypeDefault:
            iconSize = (CGSize){kIconDefaultW,kIconDefaultH};
            break;
        case IconTypeBig:
            iconSize = (CGSize){kIconBigW,kIconBigH};
            break;
    }
    return (CGSize){iconSize.width+kVerifyW*0.5,iconSize.height+kVerifyH*0.5};
}
-(void)setUser:(DLXStatusUser *)user type:(IconType)type
{
    self.user = user;
    self.type = type;
}
@end
