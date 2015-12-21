//
//  DLXMeProfileCell.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLXStatusUser;
#define kMeProfileCellH 70.f
@interface DLXMeProfileCell : UITableViewCell
-(void)setMeProfileWithUser:(DLXStatusUser *)user;
@end
