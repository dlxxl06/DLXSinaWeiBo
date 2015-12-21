//
//  DLXMeInfoCell.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXMeInfoCell.h"
#import "DLXStatusUser.h"
#import "DLXMeInfoView.h"


#define kColNum 3
@interface DLXMeInfoCell()
{
    DLXMeInfoView *_statusView;//微博数
    DLXMeInfoView *_friendView;//关注数
    DLXMeInfoView *_followView;//粉丝数
}
@end

@implementation DLXMeInfoCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = self.bounds.size.width;
    CGFloat y = self.bounds.size.height;
    [_statusView setFrame:(CGRect){0,0,x/3.0,y}];
    [_friendView setFrame:(CGRect){x/3.0,0,x/3.0,y}];
    [_followView setFrame:(CGRect){x/3.0*2,0,x/3.0,y}];
//    NSLog(@"statusView:%@",NSStringFromCGRect(_statusView.frame));
//     NSLog(@"friendView:%@",NSStringFromCGRect(_friendView.frame));
//     NSLog(@"followView:%@",NSStringFromCGRect(_followView.frame));
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (!_statusView) {
            _statusView = [[DLXMeInfoView alloc]init];
            [self.contentView addSubview:_statusView];
        }
        if (!_followView) {
             _followView = [[DLXMeInfoView alloc]init];
             [self.contentView addSubview:_followView];
        }
        if (!_friendView) {
            _friendView = [[DLXMeInfoView alloc]init];
            [self.contentView addSubview:_friendView];
        }
    }
    return self;
}
-(void)setMeInfoWithUser:(DLXStatusUser *)user
{
    [_statusView setNumAndText:user.statuses_count numText:@"微博"];
    [_friendView setNumAndText:user.friends_count numText:@"关注"];
    [_followView setNumAndText:user.followers_count numText:@"粉丝"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
