//
//  DLXMeInfoCell.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLXStatusUser;

#define kMeInfoCellH 50.f
@interface DLXMeInfoCell : UITableViewCell
-(void)setMeInfoWithUser:(DLXStatusUser *)user;
@end
