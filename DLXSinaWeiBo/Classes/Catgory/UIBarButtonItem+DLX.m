//
//  UIBarButtonItem+DLX.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UIBarButtonItem+DLX.h"
#import "NSString+DLX.h"
#import "DLXButton.h"

@implementation UIBarButtonItem (DLX)
#pragma mark -动态方法自定义图片按钮
-(instancetype)initWithNormalName:(NSString *)normalName target:(id)target action:(SEL)action
{
    UIImage *imageN = [UIImage imageNamed:normalName];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:(CGRect){CGPointZero,imageN.size}];
    [btn setImage:imageN forState:UIControlStateNormal];
    NSString *HighName = [normalName stringAppendString:@"_highlighted"];
    UIImage *imageH = [UIImage imageNamed:HighName];
    [btn setImage:imageH forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:btn];
}
#pragma mark -静态方法，自定义图片按钮
+(instancetype)buttonWithNormalName:(NSString *)normalName target:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc]initWithNormalName:normalName target:target action:action];
}
#pragma mark -动态方法自定义文字按钮方法
-(instancetype)initwithNormalTitle:(NSString *)title target:(id)target action:(SEL)action
{
    //根据文本大小调整button的frame
    CGSize titleSize =TEXTSIZE(title, 14.5f);
    //创建button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:(CGRect){CGPointZero,titleSize}];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:Font(14.5f)];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:btn];
}
+(id)ButtonWithNormalTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc]initwithNormalTitle:title target:target action:action];
}
+(instancetype)normalButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    DLXButton *btn = [[DLXButton alloc]initWithType:DLXButtonTypeNavigation];
    [btn setTitle:title forState:UIControlStateNormal];
    CGSize size = TEXTSIZE(btn.titleLabel.text,kNavBtnFontS);
    UIImage *navImage = [UIImage imageNamed:imageName];
   // NSLog(@"text:%@ image:%@",NSStringFromCGSize(size),NSStringFromCGSize(navImage.size));
    [btn setFrame:(CGRect){CGPointZero,size.width+navImage.size.width+2*kNavBtnLeftSpace+kNavBtnImageSpace,size.height+2*kNavBtnTopSpace}];
   // NSLog(@"frame:%@",NSStringFromCGRect(btn.frame));
    [btn setImage:navImage forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_middle_background_pushed.png"] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_middle_background.png"] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  //  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  //   NSLog(@"Titleframe:%@",NSStringFromCGRect(btn.titleLabel.frame));
  //  NSLog(@"Imageframe:%@",NSStringFromCGRect(btn.imageView.frame));
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
