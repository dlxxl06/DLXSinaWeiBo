//
//  DLXMeInfoView.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXMeInfoView.h"

@interface DLXMeInfoView()
{
    UILabel *_numLabel;
    UILabel *_textLabel;
    NSString *_urlStr;
}

@end
@implementation DLXMeInfoView
-(instancetype)init
{
    if (self = [super init])
    {
        _numLabel = [[UILabel alloc]init];
        _textLabel = [[UILabel alloc]init];
        [_numLabel setFont:Font(17.f)];
        [_textLabel setFont:Font(15.f)];
        [_textLabel setTextColor:[UIColor grayColor]];
        [self addSubview:_numLabel];
        [self addSubview:_textLabel];
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(tapView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)setNumAndText:(NSInteger)num numText:(NSString *)text
{
    [_numLabel setText:[NSString stringWithFormat:@"%ld",num]];
    [_textLabel setText:text];
}
-(void)layoutSubviews
{
    CGFloat x = self.bounds.size.width;
    CGFloat y = self.bounds.size.height;
    CGSize numSize = TEXTSIZE(_numLabel.text, 17.f);
    CGSize textSize = TEXTSIZE(_textLabel.text, 15.f);
    [_numLabel setFrame:(CGRect){CGPointZero,numSize}];
    [_numLabel setCenter:CGPointMake(x*0.5, y*0.25)];
    [_textLabel setFrame:(CGRect){CGPointZero,textSize}];
    [_textLabel setCenter:CGPointMake(x*0.5, y*0.75)];

    //NSLog(@"num:%@",NSStringFromCGRect(numLabel.frame));
   // NSLog(@"text:%@",NSStringFromCGRect(textLabel.frame));
}
-(void)touchDown
{
    [self setBackgroundColor:RGBA(240, 240, 240, 1)];
}
-(void)tapView
{
    [self setBackgroundColor:[UIColor whiteColor]];
    NSLog(@"tapView");
}
@end
