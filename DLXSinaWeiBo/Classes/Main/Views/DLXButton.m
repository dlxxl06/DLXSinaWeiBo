//
//  DLXDockItem.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXButton.h"
//#import "UIImage+DLXCompImage.h"


#define kNewMessageFont 13
@interface DLXButton()
{
    CGSize _content;
    UILabel *_messages;
    DLXButtonType _type;
}
@end


@implementation DLXButton


-(instancetype)initWithType:(DLXButtonType)type
{
    self = [super init];
    if (self)
    {
        _type = type;
        if (DLXButtonTypeDock == _type)
        {
            [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [self.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        }
        if (DLXButtonTypeDockOnlyImage == _type)
        {
        }
        if (DLXButtonTypeNavigation == _type)
        {
            
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.titleLabel setFont:Font(kNavBtnFontS)];
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        }
    }
    return self;
}
#pragma mark -获得图片的大小
-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    if (UIControlStateNormal == state)
    {
        _content = image.size;
    }
}


#pragma mark -屏蔽掉高亮的设置
-(void)setHighlighted:(BOOL)highlighted
{
    if (DLXButtonTypeDock == _type || DLXButtonTypeDockOnlyImage == _type){};
    if (DLXButtonTypeNavigation == _type) { [super setHighlighted:highlighted]; }
}

#pragma mark -设置内容大小为图片的大小
-(CGRect)contentRectForBounds:(CGRect)bounds
{
    
    if (DLXButtonTypeDock == _type || DLXButtonTypeDockOnlyImage == _type)
    {
        CGFloat w,h;
        w=_content.width;
        h=_content.height/kImageRatio;
        if (DLXButtonTypeDockOnlyImage == _type) h=_content.height;
        CGFloat boundW = bounds.size.width;
        CGFloat boundH = bounds.size.height;
        return CGRectMake((boundW-w)*0.5, (boundH-h)*0.5, w, h);
    }
    else
       return [super contentRectForBounds:bounds];
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if(DLXButtonTypeDock == _type || DLXButtonTypeDockOnlyImage == _type)
    {
        if (DLXButtonTypeDockOnlyImage == _type) return CGRectZero;
        return CGRectMake(contentRect.origin.x,contentRect.size.height*kImageRatio, contentRect.size.width, contentRect.size.height*(1-kImageRatio));
    }
    else if(DLXButtonTypeNavigation == _type)
    {
       // NSLog(@"contentRect:%@",NSStringFromCGRect(contentRect));
        return (CGRect){kNavBtnLeftSpace,0,contentRect.size.width-2*kNavBtnLeftSpace-_content.width-kNavBtnImageSpace,contentRect.size.height};
    }
    else return [super titleRectForContentRect:contentRect];
  
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (DLXButtonTypeDock == _type || DLXButtonTypeDockOnlyImage == _type)
    {
        if (DLXButtonTypeDockOnlyImage == _type) return contentRect;
        return CGRectMake(contentRect.origin.x, 0, contentRect.size.width, contentRect.size.height*kImageRatio);
    }
    else if(DLXButtonTypeNavigation == _type)
    {
        return (CGRect){contentRect.size.width-_content.width-kNavBtnLeftSpace,(contentRect.size.height-_content.height)*0.5,_content};
    }
    else return [super imageRectForContentRect:contentRect];
}
-(void)setNewMessages:(NSInteger)newMessages
{
    NSString *mStr;
    if (!_messages)
    {
        _messages = [[UILabel alloc]init];
        [_messages setBackgroundColor:[UIColor redColor]];
        [_messages.layer setMasksToBounds:YES];
        [self addSubview:_messages];
    }
    if (newMessages<=0)
    {
       
        [_messages setFrame:(CGRect){0,0,10,10}];
        [_messages setCenter:CGPointMake(self.bounds.size.width*0.75, 5)];
        [_messages.layer setCornerRadius:5.f];
//        NSLog(@"%@",NSStringFromCGRect(self.frame));
        return;
    }
    mStr = newMessages>99?@"99+":[NSString stringWithFormat:@"%ld",newMessages];
    CGSize size = TEXTSIZE(mStr, kNewMessageFont);
    CGFloat w = newMessages>10?(newMessages>99?size.width+8:17.f):15.f;
    [_messages setFrame:(CGRect){0,0,w,15.f}];
    [_messages.layer setCornerRadius:7.5f];
    [_messages setCenter:CGPointMake(self.imageView.frame.origin.x+self.imageView.frame.size.width-4.5, 7.5)];
    [_messages setTextColor:[UIColor whiteColor]];
    [_messages setFont:[UIFont systemFontOfSize:13.0f]];
    [_messages setTextAlignment:NSTextAlignmentCenter];
    [_messages setText:mStr];
}
@end
