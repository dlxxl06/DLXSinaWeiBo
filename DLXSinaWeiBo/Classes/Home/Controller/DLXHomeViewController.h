//
//  DLXHomeViewController.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/9/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLXPicViewDelegate;
@class DLXStatusUser;

@interface DLXHomeViewController : UITableViewController
@property (nonatomic,weak) id<DLXPicViewDelegate> cellPicViewDelegate;
extern DLXStatusUser *statusUser;
@end
