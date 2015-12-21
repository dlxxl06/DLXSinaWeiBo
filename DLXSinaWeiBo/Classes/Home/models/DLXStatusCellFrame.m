//
//  DLXStatusCellFrame.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXStatusCellFrame.h"
#import "DLXStatus.h"
#import "DLXStatusUser.h"
#import "DLXIconView.h"

@implementation DLXStatusCellFrame

#pragma mark -设置微博时求出cell的尺寸
-(void)setStatus:(DLXStatus *)status
{
    _status = status;
    _cellHeight = 0;
    if (_status)
    {
        CGFloat cellW = [[UIScreen mainScreen] bounds].size.width;
        //1.用户头像
        _iconFrame = (CGRect){kSpaceInterval,kSpaceInterval,[DLXIconView iconViewSizeWithType:IconTypeSmall]};
        //2.用户昵称
        CGSize screenNameSize =TEXTSIZE(status.user.screen_name,kScreenNameSize);
        _screenNameFrame= (CGRect){CGRectGetMaxX(_iconFrame)+kSpaceInterval,kSpaceInterval,screenNameSize};
       //10 。会员
        _iconMBFrame = (CGRect){CGRectGetMaxX(_screenNameFrame),kSpaceInterval+(_screenNameFrame.size.height-kIconMBH)*0.5,kIconMBW,kIconMBH};
        //3.创建时间
       
        //4.来源
       
        //5.微博文字
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        UIFont *fonts = Font(kStatusTextSize);
        [style setMinimumLineHeight:fonts.lineHeight];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        CGSize statusTextSize =[status.text boundingRectWithSize:CGSizeMake(cellW-2*kSpaceInterval, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:Font(kStatusTextSize),NSParagraphStyleAttributeName:style} context:nil].size;
        CGFloat iconFrameY =CGRectGetMaxY(_iconFrame);
        CGFloat createAtFrameY =CGRectGetMaxY(self.createAtFrame);
        _statusTextFrame = (CGRect){kSpaceInterval,(iconFrameY>createAtFrameY?iconFrameY:createAtFrameY)+kSpaceInterval,statusTextSize};
        //6.微博图片
        if (status.pic_urls.count>0)
        {
            NSInteger picRow = (status.pic_urls.count+kRowNum-1)/kRowNum;
            CGFloat picFrameW = cellW-2*kSpaceInterval;
            CGFloat picFrameH = picRow*kPicImageH+(picRow-1)*kPicImageSpace;
             _picFrame = (CGRect){kSpaceInterval,CGRectGetMaxY(_statusTextFrame)+kSpaceInterval,picFrameW,picFrameH};
        }
       
       
        if (status.retweeted_status)
        {
             CGFloat retweetedH=2*kSpaceInterval;
            //*******************转发微博的高度**************************
            //8。转发微博的文字、昵称
            NSString *retweeted = [NSString stringWithFormat:@"@%@: %@",status.retweeted_status.user.screen_name,status.retweeted_status.text];
            NSMutableParagraphStyle *style2 = [[NSMutableParagraphStyle alloc]init];
            UIFont *fonts2 = Font(kRetweetedTextSize);
            [style setMinimumLineHeight:fonts2.lineHeight+3];
            [style setLineBreakMode:NSLineBreakByCharWrapping];
            CGSize retweetedTextSize =[retweeted boundingRectWithSize:CGSizeMake(cellW-2*kSpaceInterval, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:Font(kRetweetedTextSize),NSParagraphStyleAttributeName:style2} context:nil].size;
            _retweetedTextFrame = (CGRect){kSpaceInterval,0,retweetedTextSize};
            retweetedH +=_retweetedTextFrame.size.height;
            //9.转发微博的图片
            if (status.retweeted_status.pic_urls.count>0)
            {
                NSInteger retweetedPicRow = (status.retweeted_status.pic_urls.count+kRowNum-1)/kRowNum;
                CGFloat retweetedPicFrameW = cellW-2*kSpaceInterval;
                CGFloat retweetedPicFrameH = retweetedPicRow*kPicImageH+(retweetedPicRow-1)*kPicImageSpace;
                _retweetedPicFrame = (CGRect){kSpaceInterval,CGRectGetMaxY(_retweetedTextFrame)+kSpaceInterval,retweetedPicFrameW,retweetedPicFrameH};
                retweetedH += _retweetedPicFrame.size.height;
            }
            //7.转发微博的父控件
            CGFloat retweetedY =status.pic_urls.count>0?CGRectGetMaxY(_picFrame): CGRectGetMaxY(_statusTextFrame);
            retweetedY +=kSpaceInterval;
            _retweetedFrame = (CGRect){0,retweetedY,cellW,retweetedH};
//            NSLog(@"retweeted:%lf",retweetedH);
        }
        _cellHeight += status.retweeted_status?CGRectGetMaxY(_retweetedFrame):(status.pic_urls.count>0?CGRectGetMaxY(_picFrame)+kSpaceInterval:CGRectGetMaxY(_statusTextFrame)+kSpaceInterval);
        //11. 评论条
        _retweetedBarFrame = (CGRect){0,_cellHeight,cellW,kRetweetedBarH};
        _cellHeight +=kRetweetedBarH;
//        NSLog(@"cellHeight:%lfpic:%lf",_cellHeight,CGRectGetMaxY(_picFrame));
    }
}

//更新create_at的frame
-(CGRect)createAtFrame
{
     //3.创建时间
    CGSize createAtSize = TEXTSIZE(_status.created_at, kCreateAtSize);
   return  (CGRect){CGRectGetMaxX(_iconFrame)+kSpaceInterval,CGRectGetMaxY(_screenNameFrame)+kSpaceInterval,createAtSize};

}
-(CGRect)sourceFrame
{
    CGSize sourceSize = TEXTSIZE(_status.source, kSourceSize);
    return  (CGRect){CGRectGetMaxX(self.createAtFrame)+kSpaceInterval,self.createAtFrame.origin.y,sourceSize};
}
@end
