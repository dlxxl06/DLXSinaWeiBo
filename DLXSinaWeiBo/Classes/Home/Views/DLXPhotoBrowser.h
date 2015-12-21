//
//  DLXPhotoBrowser.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/22.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLabelH 40
typedef void(^PhotoBrowerBlock)(NSInteger currentIndex);

@interface DLXPhotoBrowser : UIView
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,strong) NSArray *pic_urls;
-(void)setBackBlock:(PhotoBrowerBlock )backBlock;
@property (nonatomic,assign)UIViewContentMode BrowerContentMode;
@property (nonatomic,assign)BOOL scrollViewHidden;
@end
