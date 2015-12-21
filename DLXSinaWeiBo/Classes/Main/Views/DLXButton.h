//
//  DLXDockItem.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kImageRatio 0.7

#define kNavBtnFontS 17.f
#define kNavBtnLeftSpace 8
#define kNavBtnTopSpace 8
#define kNavBtnImageSpace 4
typedef NS_ENUM(NSInteger, DLXButtonType)
{
    DLXButtonTypeDock,
    DLXButtonTypeDockOnlyImage,
    DLXButtonTypeNavigation
};
@interface DLXButton: UIButton
-(instancetype)initWithType:(DLXButtonType)type;
@property (nonatomic,assign) NSInteger newMessages; //only type is equal to DLXButtonTypeDock;
@end
