//
//  DLXPicView.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/22.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLXPicView;
@protocol DLXPicViewDelegate <NSObject>

-(void)DLXPicView:(DLXPicView *)picView pic_urls:(NSArray *)pic_urls index:(id)index;

@end
@interface DLXPicView : UIView

@property (nonatomic,weak) id<DLXPicViewDelegate> delegate;
@property (nonatomic,assign) UIViewContentMode sourceContentMode;
-(void)setImageView:(NSArray *)pic_urls;
@end
