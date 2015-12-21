//
//  DLXDockView.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXDockView.h"
#import "DLXButton.h"

@interface DLXDockView()
{
    DLXButton *_preItem;
}
@end

#define Screen [UIScreen mainScreen].applicationFrame

@implementation DLXDockView

-(instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor colorWithPatternImage:_patternImage]];
        
    }
    return self;
    
}
+(instancetype)dockView
{
    CGFloat kWifiH;
    if (Screen.size.height>=667) {
        kWifiH = 0;
    }
    else kWifiH = 20;
   return  [[DLXDockView alloc]initWithFrame:(CGRect){0,Screen.size.height-kDockHeight+kWifiH,Screen.size.width,kDockHeight}];
}
#pragma mark -添加dockItem
-(void)addItem:(id)image selected:(id)selected buttonName:(NSString *)name
{
    DLXButton *Item;
    if ([name isEqualToString:@""]|| !name) {
        Item = [[DLXButton alloc]initWithType:DLXButtonTypeDockOnlyImage];
    }
    else Item = [[DLXButton alloc]initWithType:DLXButtonTypeDock];
    [Item setTitle:name forState:UIControlStateNormal];
    [Item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:Item];
    NSInteger count = self.subviews.count;
    //进入指定的item
    if (count == _defautItem) {
        [self itemAction:Item];
        _preItem = Item;
    }
    
    
    if ([image isKindOfClass:[UIImage class]]) {
        [Item setImage:(UIImage *)image forState:UIControlStateNormal];
    if ([selected isKindOfClass:[NSString class]])
        assert("selected object class must is the same as image object class");

        [Item setImage:(UIImage *)selected forState:UIControlStateSelected];
        return;
    }
        [Item setImage:[UIImage imageNamed:(NSString *)image] forState:UIControlStateNormal];
        UIImage *imageH = [UIImage imageNamed:selected];
        [Item setImage:imageH forState:UIControlStateSelected];
    
    
}
-(void)addItem:(NSString *)imageName backImageN:(NSString *)backImage backImageH:(NSString *)backImageH
{
    DLXButton *item = [[DLXButton alloc]initWithType:DLXButtonTypeDockOnlyImage];
    UIImage *image = [UIImage imageNamed:imageName];
    [item setImage:image forState:UIControlStateNormal];
    [item setBackgroundImage:[UIImage imageNamed:backImageH ] forState:UIControlStateHighlighted];
    [item setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
    [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
}

-(void)layoutSubviews
{
    NSInteger count = self.subviews.count;
    CGFloat w = self.bounds.size.width*1.0/count;
    CGFloat h = self.bounds.size.height;
   
    [self.subviews enumerateObjectsUsingBlock:^(DLXButton *Item, NSUInteger idx, BOOL *stop) {
            [Item setTag:idx];
            [Item setFrame:CGRectMake(idx*w, 0, w, h)];
    }];
}

#pragma mark -dockViewItem的方法

#pragma mark -touchDown方法
-(void)itemAction:(DLXButton *)sender
{
    if ([_delegate respondsToSelector:@selector(dockView:from:moveTo:)]) {
        [_delegate dockView:self from:_preItem.tag moveTo:sender.tag];
    }
    if (_preItem == sender || sender.tag == 2) {
        return;
    }
    [_preItem setSelected:NO];
    [sender setSelected:YES];
    _preItem = sender;
}
#pragma mark -移除所有的subViews
-(void)removeAllSubViews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}
#pragma mark -点击指定的按钮
-(void)actionAtIndex:(NSInteger)index
{
    for (DLXButton *item in self.subviews)
    {
        if (item.tag == index) [self itemAction:item];
    }
}
#pragma mark -设置新的消息
-(void)setNewMessages:(NSInteger)messageNum atIndex:(NSInteger)index
{
    DLXButton *item = self.subviews[index];
    [item setNewMessages:messageNum];

}
@end
