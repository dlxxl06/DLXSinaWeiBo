//
//  DLXStatusTextView.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/19.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchStringSuccess)(NSArray *arrayOfAllMatches);
typedef void(^SearchStringFailure)(NSError *error);

@interface DLXStatusTextView : UIView
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *textColor;
-(void)decorateTextWithString:(NSString *)sourceString;
@end
