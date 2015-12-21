//
//  DLXComposeItems.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXComposeItems.h"
#import "DLXButton.h"
#import "DLXCommAnimation.h"
#import "DLXAddDefine.h"

#define kItemNum 6
#define kColNum 3

@interface DLXComposeItems()
{
    NSMutableArray *_items;
    NSMutableArray *_moreItems;
}
@end

@implementation DLXComposeItems

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _items = [NSMutableArray arrayWithCapacity:kItemNum];
        _moreItems = [NSMutableArray arrayWithCapacity:kItemNum-1];
        [self addItem:COMPOSE_IDEA title:@"文字" action:@selector(tapFirstItems:) page:1];
        [self addItem:COMPOSE_PHOTO title:@"图片" action:@selector(tapFirstItems:) page:1];
        [self addItem:COMPOSE_WEIBO title:@"长微博"  action:@selector(tapFirstItems:)page:1];
        [self addItem:COMPOSE_LBS title:@"位置" action:@selector(tapFirstItems:) page:1];
        [self addItem:COMPOSE_REVIEW title:@"点评" action:@selector(tapFirstItems:) page:1];
        [self addItem:COMPOSE_MORE title:@"更多" action:@selector(tapFirstItems:) page:1];
        //第二组
        [self addItem:COMPOSE_FRIEND title:@"好友圈" action:@selector(tapSecondItems:) page:2];
        [self addItem:COMPOSE_WBCAMERA title:@"相册" action:@selector(tapSecondItems:) page:2];
        [self addItem:COMPOSE_MUSIC title:@"音乐" action:@selector(tapSecondItems:) page:2];
        [self addItem:COMPOSE_CAMERA title:@"拍摄" action:@selector(tapSecondItems:) page:2];
        [self addItem:COMPOSE_TRANSFER title:@"收款" action:@selector(tapSecondItems:) page:2];
        //第一组按钮的布局
        [self enumrateObject:_items hidden:NO];
        //第二组按钮的布局
        [self enumrateObject:_moreItems hidden:YES];
       // [self setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}

-(void)addItem:(NSString *)imageName title:(NSString *)title action:(SEL)action page:(NSInteger)page
{
    DLXButton *item = [[DLXButton alloc]initWithType:DLXButtonTypeDock];
    UIImage *imageN = [UIImage imageNamed:imageName];
    [item setImage:imageN forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateNormal];
    [item addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [item addTarget:self action:@selector(buttonMakeBig:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:item];
    if (page ==1) {
        [_items addObject:item];
    }
    else [_moreItems addObject:item];
}

#pragma mark -按钮放大方法
-(void)buttonMakeBig:(DLXButton *)sender
{
    [sender setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
}

#pragma mark -item的事件方法
#pragma mark 第一组的items的方法
-(void)tapFirstItems:(DLXButton *)sender
{
    [sender setTransform:CGAffineTransformIdentity];
    [_deletage ComposeItem:sender page:1 index:sender.tag];
}
#pragma mark -第二组items的方法
-(void)tapSecondItems:(DLXButton *)sender
{
    [sender setTransform:CGAffineTransformIdentity];
    [_deletage ComposeItem:sender page:2 index:sender.tag];
}

-(void)startMoveUpAnimation
{
    for (DLXButton *item in _items) {
        [item setHidden:NO];
        [item.layer setOpacity:1.f];
    }
    for (DLXButton *item in _moreItems) {
        [item setHidden:YES];
        [item.layer setOpacity:1.f];
    }
    //****************************动画初始化{
    for (DLXButton *item in _items) {
        CAAnimationGroup *moveup = [DLXCommAnimation moveLongAnimation:@"moveUp" values:@[@(self.bounds.size.height),@(item.center.y-10),@(item.center.y)]duration:0.5f];
        [item.layer addAnimation:moveup forKey:@"MoveUpAnim"];
    }
    //****************************动画初始化}
   
    
}
-(void)startMoveDownAnimation
{
    DLXButton *item=_items[0];
    NSMutableArray *currentItems = _items;
    if (item.hidden) {
        currentItems = _moreItems;
    }
    for (DLXButton *item in currentItems) {
        CAAnimationGroup *moveDown = [DLXCommAnimation moveLongAnimation:@"moveDown" values:@[@(item.center.y),@(item.center.y+700)]duration:0.8f];
        [item.layer addAnimation:moveDown forKey:@"moveDownAnim"];
    }
}
-(void)startMoveRightAnimation
{
    //item向左移
    [_items enumerateObjectsUsingBlock:^(DLXButton *item, NSUInteger idx, BOOL *stop) {
        CAKeyframeAnimation *moveLeft = [DLXCommAnimation moveCrossAnimation:@"moveLeft" values:@[@(item.center.x),@(item.center.x-self.bounds.size.width)]];
        [item.layer addAnimation:moveLeft forKey:@"moveLeft"];
        [UIView animateWithDuration:0.4f animations:^{
            [item.layer setOpacity:0];
        } completion:^(BOOL finished) {
            [item setHidden:YES];
        }];
    }];
    
    [_moreItems enumerateObjectsUsingBlock:^(DLXButton *item, NSUInteger idx, BOOL *stop) {
        [item setHidden:NO];
        [item.layer setOpacity:1.0f];
        CAKeyframeAnimation *moveRight = [DLXCommAnimation moveCrossAnimation:@"moveRight" values:@[@(self.bounds.size.width+item.center.x),@(item.center.x)]];
        [item.layer addAnimation:moveRight forKey:@"moveRight"];
    }];
}
#pragma mark -按钮布局
-(void)enumrateObject:(NSMutableArray *)array hidden:(BOOL)hidden
{
    __block NSInteger row,col;
    __block CGFloat w = self.bounds.size.width/kColNum;
    __block CGFloat y = self.bounds.size.height*0.2;
    [array enumerateObjectsUsingBlock:^(DLXButton *item, NSUInteger idx, BOOL *stop) {
        row = idx%kColNum;
        col = idx/kColNum;
        [item.layer setOpacity:1.f];
        [item setFrame:(CGRect){w*row,y+col*(item.imageView.image.size.height/kImageRatio+10),w,item.imageView.image.size.height/kImageRatio}];
        [item setTag:idx];
        [item setHidden:hidden];
    }];
}
-(void)startMoveLeftAnimation
{
    //item向右移
    [_moreItems enumerateObjectsUsingBlock:^(DLXButton *item, NSUInteger idx, BOOL *stop) {
        CAKeyframeAnimation *moveLeft = [DLXCommAnimation moveCrossAnimation:@"moveRight" values:@[@(item.center.x),@(item.center.x+self.bounds.size.width)]];
        [item.layer addAnimation:moveLeft forKey:@"moveRight"];
        [UIView animateWithDuration:0.4f animations:^{
            [item.layer setOpacity:0];
        } completion:^(BOOL finished) {
            [item setHidden:YES];
        }];
    }];
    
    [_items enumerateObjectsUsingBlock:^(DLXButton *item, NSUInteger idx, BOOL *stop) {
        [item setHidden:NO];
        [item.layer setOpacity:1.f];
        CAKeyframeAnimation *moveRight = [DLXCommAnimation moveCrossAnimation:@"moveLeft" values:@[@(item.center.x-self.bounds.size.width),@(item.center.x)]];
        [item.layer addAnimation:moveRight forKey:@"moveLeft"];
    }];

    
}
@end
