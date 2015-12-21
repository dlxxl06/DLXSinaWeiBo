//
//  DLXDockView.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDockHeight 44



@class DLXDockView;

@protocol DLXDockViewDelegate <NSObject>

@optional
-(void)dockView:(DLXDockView *)dockView from:(NSInteger )from moveTo:(NSInteger )moveTo;
-(void)dockView:(DLXDockView *)dockView index:(NSInteger )index total:(NSInteger)total;
@end

@interface DLXDockView : UIView

@property (nonatomic,weak) id<DLXDockViewDelegate> delegate;
@property (nonatomic,strong) UIImage *patternImage;
@property (nonatomic,assign) NSInteger defautItem;
#pragma mark 添加有选中图片的子项
-(void)addItem:(id)image selected:(id)selected buttonName:(NSString *)name;
#pragma mark 添加有背景图片的子项
-(void)addItem:(NSString *)imageName backImageN:(NSString *)backImage backImageH:(NSString *)backImageH;

//-(void)addItem:(id)image selected:(id)selected buttonName:(NSString *)name
+(instancetype)dockView;

-(void)removeAllSubViews;
#pragma mark -点击指定的按钮
-(void)actionAtIndex:(NSInteger)index;
#pragma mark -设置新的消息
-(void)setNewMessages:(NSInteger )messageNum atIndex:(NSInteger)index;
@end
