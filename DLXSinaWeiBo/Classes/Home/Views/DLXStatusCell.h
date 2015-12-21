//
//  DLXStatusCell.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLXPicView.h"

@class DLXStatusCellFrame;
@interface DLXStatusCell : UITableViewCell

@property (nonatomic,weak) id<DLXPicViewDelegate> picViewDelegate;

-(void)setStatusCellWithFrame:(DLXStatusCellFrame *)frame;

@end
