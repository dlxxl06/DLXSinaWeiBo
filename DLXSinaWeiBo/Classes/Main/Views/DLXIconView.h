//
//  DLXIconView.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLXStatusUser;
typedef NS_ENUM(NSInteger,IconType)
{
    IconTypeSmall,//在首页显示
    IconTypeDefault,//在“我”显示
    IconTypeBig//在关注中显示
};

@interface DLXIconView : UIView
@property (nonatomic,assign) IconType type;
@property (nonatomic,strong) DLXStatusUser *user;
+(CGSize)iconViewSizeWithType:(IconType)type;
-(void)setUser:(DLXStatusUser *)user type:(IconType)type;
@end
