//
//  DLXDefaultCell.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXDefaultCell.h"
//#import "UIImageView+WebCache.h"
#import "UIImage+DLXCompImage.h"
@interface DLXDefaultCell()
{
   
}
@end

@implementation DLXDefaultCell

#define kTextFont 17.f
#define kDetailFont 13.f

-(void)setDLXCellStyle:(DLXDefaultCellStyle)style
{
    _DLXCellStyle = style;
    switch (_DLXCellStyle)
    {
        case DLXDefaultCellStyleImageNoAccessory:
        case DLXDefaultCellStyleImage:
            if (self)
            {
                [self.detailTextLabel setFont:Font(kDetailFont)];
                [self.detailTextLabel setTextColor:[UIColor grayColor]];
                [self.textLabel setTextColor:[UIColor blackColor]];
                [self.textLabel setFont:Font(kTextFont)];
                [self.textLabel setTextAlignment:NSTextAlignmentLeft];
                if (DLXDefaultCellStyleImage == style)
                    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
            break;
        case DLXDefaultCellStyleTitle:
            
            break;
        case DLXDefaultCellStyleSwitch:
            
            break;
        default:
            break;
    }

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize titleSize = TEXTSIZE(self.textLabel.text,kTextFont);
    CGSize detailSize = TEXTSIZE(self.detailTextLabel.text, kDetailFont);
    CGFloat y = self.bounds.size.height;
   // NSLog(@"y:%lf",y);
    switch (_DLXCellStyle) {
            case DLXDefaultCellStyleImage:
            case DLXDefaultCellStyleImageNoAccessory:
            [self.imageView setFrame:(CGRect){10,10,20,20}];
            [self.textLabel setBounds:(CGRect){0,0,titleSize}];
            [self.textLabel setCenter:CGPointMake(40+titleSize.width*0.5,y*0.5)];
            [self.detailTextLabel setBounds:(CGRect){0,0,detailSize}];
            [self.detailTextLabel setCenter:CGPointMake(self.textLabel.frame.origin.x+titleSize.width+5+detailSize.width*0.5, y*0.5)];
            break;
        case DLXDefaultCellStyleSwitch:
            break;
        case DLXDefaultCellStyleTitle:
            break;
        default:
            break;
    }

}
-(void)setIsNew:(BOOL)isNew
{
    _isNew = isNew;
    if (_isNew)
    {
        UIImage *redDotI = [UIImage redDotImage:10];
        UIImageView *redDotV = [[UIImageView alloc]initWithFrame:(CGRect){CGPointZero,redDotI.size}];
        [redDotV setImage:redDotI];
        [redDotV setCenter:self.accessoryView.center];
        self.accessoryView = redDotV;
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        return self;
}
-(void)setCardWithDataList:(NSArray *)dataList indexPath:(NSIndexPath *)indexPath
{
    NSArray *s = dataList[indexPath.section-1];
    NSDictionary *dict = s[indexPath.row];
    [self.imageView setImage:[UIImage imageNamed:dict[@"icon"]]];
    [self.textLabel setText:dict[@"title"]];
    [self.detailTextLabel setText:dict[@"detail"]];
    self.isNew = [dict[@"isNew"] boolValue];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
