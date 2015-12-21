//
//  DLXMeProfileCell.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXMeProfileCell.h"
#import "DLXStatusUser.h"
#import "UIImageView+WebCache.h"
#import "DLXMeDefine.h"

@interface DLXMeProfileCell()
{
    UIButton *_user_memberShip;
    NSMutableArray *_memShipN;
    NSMutableArray *_memShipS;
}
@end

@implementation DLXMeProfileCell

-(void)awakeFromNib {
    // Initialization code
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize nameSize = TEXTSIZE(self.textLabel.text, 17.0f);
    CGSize aboutSize = TEXTSIZE(self.detailTextLabel.text, 12.0f);
    [self.imageView setFrame:CGRectMake(10, 10, 50, 50)];
    [self.textLabel setFrame:(CGRect){70,10,nameSize.width,nameSize.height}];
    [self.detailTextLabel setFrame:(CGRect){70,self.textLabel.frame.origin.y+nameSize.height+5,aboutSize.width,aboutSize.height}];
    UIImage *image = _memShipN[0];
    [_user_memberShip setFrame:(CGRect){self.textLabel.frame.origin.x+nameSize.width+10,10,image.size}];

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        _user_memberShip = [[UIButton alloc]init];
        [self.contentView addSubview:_user_memberShip];
        [self.textLabel setFont:Font(17.f)];
        [self.detailTextLabel setFont: Font(12.f)];
        [self.detailTextLabel setTextColor:[UIColor grayColor]];
        _memShipN = [NSMutableArray arrayWithCapacity:7];
        _memShipS = [NSMutableArray arrayWithCapacity:7];
        UIImage *image1N=[UIImage imageNamed:MEMBERSHIP_EXPIRED];
        [_memShipN addObject:image1N];
        UIImage *image1S = [UIImage imageNamed:MEMBERSHIP_EXPIRED_SELECTED];
        [_memShipS addObject:image1S];
        for (NSInteger i=1; i<=6; i++)
        {
            UIImage *imageN = [UIImage imageNamed:[NSString stringWithFormat:membership_level,i]];
            UIImage *imageS = [UIImage imageNamed:[NSString stringWithFormat:membership_level_selected,i]];
            [_memShipN addObject:imageN];
            [_memShipS addObject:imageS];
        }
    }
    return self;
}

-(void)setMeProfileWithUser:(DLXStatusUser *)user
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:USER_PLACEHOLDER]];
    [self.textLabel setText:user.screen_name];
    NSString *desc = [user.description isEqualToString:@""]?@"简介:暂无简介":[NSString stringWithFormat:@"简介:%@",user.description];
    [self.detailTextLabel setText:desc];
    NSInteger index = user.verified_type;
    if(user.verified_type<0)index = 0;
    [_user_memberShip setImage:_memShipN[index] forState:UIControlStateNormal];
    [_user_memberShip setImage:_memShipS[index] forState:UIControlStateSelected];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
