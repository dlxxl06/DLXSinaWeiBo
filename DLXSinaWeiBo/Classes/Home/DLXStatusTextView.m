//
//  DLXStatusTextView.m
//  DLXSinaWeiBo
//
//  Created by admin on 15/10/19.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DLXStatusTextView.h"
#import <CoreText/CoreText.h>

#define TOPIC_EXPRESION @"(#[^#]+#)"
#define EMOTION_EXPRESION @"(\\[[\u4e00-\u9fa5a-zA-Z]*])"
#define AITE_EXPRESION @"(@[\u4e00-\u9fa5a-zA-Z0-9_]{1,30})"

#define kEmotionW 20
#define kEmotionH kEmotionW

NSString *const kEmotionAttributeName = @"emotionAttributeName";
@interface DLXStatusTextView()
{
    UILabel *_text;
    NSDictionary *_defaultDict;
    NSDictionary *_lxhDict;
    
}
@end

@implementation DLXStatusTextView

#pragma mark -图片的代理
void runDelegatedeallocCallBack(void *refCon)
{

}
#pragma mark -图片的上行高度
CGFloat rundelegateGetAscentCallBack(void *refCon)
{
   NSString *emotion = (__bridge NSString *)refCon;
    return 10.f;
}
#pragma mark -图片的下行高度
CGFloat rundelegateGetDescentCallBack(void *refCon)
{
   NSString *emotion = (__bridge NSString *)refCon;
    return 10.f;
}
#pragma mark -图片的宽度
CGFloat rundelegateGetWidthCallBack(void *refCon)
{
   NSString *emotion = (__bridge NSString *)refCon;
    return 20.f;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_text setFrame:self.bounds];
}
-(instancetype)init
{
    if (self = [super init])
    {
        _text  = [[UILabel alloc]init];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_text];
        [_text setNumberOfLines:0];
          _defaultDict= [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"defaultInfo.plist" ofType:nil] ];
        _lxhDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lxhInfo" ofType:@"plist"]];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
   
    if (_text.attributedText.string == nil)
    {
        return;
    }
    NSMutableAttributedString *attString =[[NSMutableAttributedString alloc]initWithAttributedString:_text.attributedText];
    [self searchAITE:attString];
    [self searchTOPIC:attString];
    [self searchEmotion:attString];
    [self getEmotionFrame:attString];
    [_text setAttributedText:attString];
    
    [super drawRect:rect];
}

#pragma mark -对源字符串装饰，将表情和话题加上
-(void)decorateTextWithString:(NSString *)sourceString
{
     NSMutableAttributedString *attributeString =[[NSMutableAttributedString alloc]initWithString:sourceString];
    [self searchAITE:attributeString];
    [self searchTOPIC:attributeString];
//    [self searchEmotion:attributeString];
    [_text setAttributedText:attributeString];
    
}
#pragma mark -设置文本字体
-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [_text setTextColor:_textColor];
}
#pragma mark -设置文本颜色
-(void)setFont:(UIFont *)font
{
    _font = font;
    [_text setFont:_font];
}
#pragma mark -查找“@”的内容
-(void)searchAITE:(NSMutableAttributedString *)string
{
   [self searchStringWithPattern:AITE_EXPRESION string:string.string success:^(NSArray *arrayOfAllMatches) {
       for (NSTextCheckingResult *match in arrayOfAllMatches)
       {
           [string addAttribute:NSForegroundColorAttributeName value:RGBA(62, 103, 159, 1) range:match.range];
       }
   } failure:^(NSError *error) {
       NSLog(@"%@",[error localizedDescription]);
   }];
}
#pragma mark -查找“#\w#”的内容
-(void)searchTOPIC:(NSMutableAttributedString *)string
{
   [self searchStringWithPattern:TOPIC_EXPRESION string:string.string success:^(NSArray *arrayOfAllMatches) {
       for (NSTextCheckingResult *match in arrayOfAllMatches)
       {
           [string addAttribute:NSForegroundColorAttributeName value:RGBA(62, 103, 159, 1) range:match.range];
       }
   } failure:^(NSError *error) {
       NSLog(@"%@",[error localizedDescription]);
   }];
   
}
#pragma mark -查找表情
-(void)searchEmotion:(NSMutableAttributedString *)string
{
    [self searchStringWithPattern:EMOTION_EXPRESION string:string.string success:^(NSArray *arrayOfAllMatches) {
        for (NSTextCheckingResult *match in arrayOfAllMatches)
        {
            [self decorateAttributeString:string range:match.range];
            [self getEmotionFrame:string];
            NSMutableString *str = [NSMutableString string];
            for (NSInteger i=0; i<match.range.length; i++)
            {
                [str appendString:@" "];
            }
            [string replaceCharactersInRange:match.range withString:str];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}
#pragma mark -通用查找
-(void)searchStringWithPattern:(NSString *)pattern string:(NSString *)string success:(SearchStringSuccess)success failure:(SearchStringFailure)failure
{
     NSError *error;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (error == nil)
    {
        NSArray *arrayOfAllMatches = [expression matchesInString:string options:0 range:NSMakeRange(0, [string length])];
        success(arrayOfAllMatches);
    }
    else
    {
        if (failure==nil)
        {
            return;
        }
         failure(error);
    }
    
}
#pragma mark -加载表情
-(void)loadEmotionWithArray:(NSString *)text rect:(CGRect)rect
{
//    NSLog(@"%@",NSStringFromCGRect(rect));
    NSArray *defaultEmotions = _defaultDict[@"emoticons"];
    NSArray *lxhEmotions = _lxhDict[@"emoticons"];
    for (NSInteger i=0; i<defaultEmotions.count; i++)
    {
      
        NSDictionary *eDict = defaultEmotions[i];
        if ([text isEqualToString:eDict[@"chs"]])
        {
            UIImage *eImage = [UIImage imageNamed:eDict[@"png"]];
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:rect];
            [imageV setImage:eImage];
            [self addSubview:imageV];
            break;
            return;
        }
    }
    for (NSInteger j=0; j<lxhEmotions.count; j++)
    {
        NSDictionary *lxhDict = defaultEmotions[j];
        if ([text isEqualToString:lxhDict[@"chs"]])
        {
            UIImage *lxhImage = [UIImage imageNamed:lxhDict[@"png"]];
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:rect];
            [imageV setImage:lxhImage];
            [self addSubview:imageV];
            break;
            return;
        }
    }
    
}


#pragma mark -给表情加代理
-(void)decorateAttributeString:(NSMutableAttributedString *)attString range:(NSRange)range
{
    NSString *emotion = [attString.string substringWithRange:range];
    [attString addAttribute:kEmotionAttributeName value:emotion range:range];
    CTRunDelegateCallbacks callbacks;
    callbacks.version = kCTRunDelegateCurrentVersion;
    callbacks.getAscent = rundelegateGetAscentCallBack;
    callbacks.getDescent = rundelegateGetDescentCallBack;
    callbacks.getWidth = rundelegateGetWidthCallBack;
    callbacks.dealloc = runDelegatedeallocCallBack;
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(emotion));
    [attString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)(runDelegate) range:range];

}
#pragma mark -得到表情的frame - 有错误
-(void)getEmotionFrame:(NSMutableAttributedString *)string
{
//    //绘图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //修正坐标系
    CGAffineTransform affine = CGAffineTransformIdentity;
    affine = CGAffineTransformMakeTranslation(0.0, self.frame.size.height);
    affine = CGAffineTransformScale(affine, 1.0, -1.f);
    CGContextConcatCTM(ctx, affine);
    
    CGMutablePathRef pathReft = CGPathCreateMutable();//创建一个文字路径，充当bounds
    CGPathAddRect(pathReft, NULL, self.bounds);
    //用framesetter管理描画文字的frame
    CTFramesetterRef frameSetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)string);
    //创建frame 是描画文字的视图范围
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetterRef, CFRangeMake(0, 0), pathReft, nil);
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), lineOrigins);
//    NSLog(@"%@",NSStringFromCGPoint(lineOrigins[CFArrayGetCount(lines)]));
    for(NSInteger i=0;i<CFArrayGetCount(lines);i++)
    {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
//        NSLog(@"line:%f lineAscent:%f lineDescent:%f lineLeading:%f",line,lineAscent,lineDescent,lineLeading);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (NSInteger j=0; j<CFArrayGetCount(runs); j++)
        {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary *attributes =(NSDictionary *)CTRunGetAttributes(run);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, NULL);
            runRect = CGRectMake(lineOrigin.x+CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y, runRect.size.width, runAscent+runDescent);
       
            NSString *emotion = [attributes objectForKey:kEmotionAttributeName];
            if (emotion)
            {
                CGRect imageFrame;
                imageFrame = CGRectMake(runRect.origin.x+lineOrigin.x,lineOrigin.y, runRect.size.width, lineAscent+lineDescent);
                NSLog(@"%@",NSStringFromCGRect(imageFrame));
                [self loadEmotionWithArray:emotion rect:imageFrame];
            }
        }
        
    }
}

@end
