//
//  DLXDefaultCell.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultCellH 40.f
typedef NS_ENUM(NSInteger, DLXDefaultCellStyle)
{
    DLXDefaultCellStyleImage = 1<<1,
    DLXDefaultCellStyleImageNoAccessory = 1<<2,
    DLXDefaultCellStyleTitle = 1<<3,
    DLXDefaultCellStyleSwitch = 1<<4,
    DLXDefaultCellStyleLogoOut = 1<<5,
    
};
@interface DLXDefaultCell : UITableViewCell
@property (nonatomic,assign) DLXDefaultCellStyle DLXCellStyle;
@property (nonatomic,assign) BOOL isNew;
-(void)setCardWithDataList:(NSArray *)dataList indexPath:(NSIndexPath *)indexPath;
@end
