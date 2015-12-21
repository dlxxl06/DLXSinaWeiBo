//
//  UIBarButtonItem+DLX.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DLX)
-(instancetype)initWithNormalName:(NSString *)normalName target:(id)target action:(SEL)action;
+(instancetype)buttonWithNormalName:(NSString *)normalName target:(id)target action:(SEL)action;
-(instancetype)initwithNormalTitle:(NSString *)title target:(id)target action:(SEL)action;
+(id)ButtonWithNormalTitle:(NSString *)title target:(id)target action:(SEL)action;
+(instancetype)normalButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;
@end
