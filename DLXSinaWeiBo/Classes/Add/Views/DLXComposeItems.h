//
//  DLXComposeItems.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLXButton;
@protocol DLXComposeItemsDelegate <NSObject>

-(void)ComposeItem:(DLXButton *)item page:(NSInteger)page index:(NSInteger)index;

@end

@interface DLXComposeItems : UIView
@property (nonatomic,weak) id<DLXComposeItemsDelegate> deletage;
-(void)startMoveUpAnimation;
-(void)startMoveLeftAnimation;
-(void)startMoveDownAnimation;
-(void)startMoveRightAnimation;
@end
