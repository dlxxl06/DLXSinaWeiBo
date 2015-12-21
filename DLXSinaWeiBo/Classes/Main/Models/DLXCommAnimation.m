//
//  DLXCommAnimation.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXCommAnimation.h"

@implementation DLXCommAnimation

#pragma mark -item上下的的动画
+(CAAnimationGroup *)moveLongAnimation:(NSString *)type values:(NSArray *)values duration:(CGFloat )duration
{
    CAKeyframeAnimation *moveLong = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    moveLong.values=values;
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = @(0);
    opacity.toValue = @(1);
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[moveLong,opacity];
    [group setValue:type forKey:@"animationType"];
    group.repeatCount =1;
    group.autoreverses = NO;
    group.speed = 1.5;
    group.duration =duration;
    return group;
}
+(CAKeyframeAnimation *)moveCrossAnimation:(NSString *)type values:(NSArray *)array
{
    CAKeyframeAnimation *moveCross = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    moveCross.values = array;
    [moveCross setRepeatCount:1];
    [moveCross setDuration:0.5f];
    [moveCross setAutoreverses:NO];
    [moveCross setSpeed:1.5f];
    [moveCross setValue:type forKey:@"animationType"];
    return moveCross;
}
@end
