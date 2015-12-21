//
//  DLXRetweetedBar.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLXRetweetedBarDelegate<NSObject>

-(void)DLXRetweetedButton:(UIButton *)btn index:(NSInteger)index;

@end
@interface DLXRetweetedBar : UIView
@property (nonatomic,weak) id<DLXRetweetedBarDelegate> delegate;
-(void)setReposts:(NSInteger )reposts comments:(NSInteger)comments attitudes:(NSInteger)attitudes;
@end
