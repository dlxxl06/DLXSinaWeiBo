//
//  DLXCommAnimation.h
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLXCommAnimation : NSObject
#pragma mark -item上下的的动画
+(CAAnimationGroup *)moveLongAnimation:(NSString *)type values:(NSArray *)values duration:(CGFloat )duration;
+(CAKeyframeAnimation *)moveCrossAnimation:(NSString *)type values:(NSArray *)array;
@end
