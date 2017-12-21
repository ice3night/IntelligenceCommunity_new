//
//  ActivityDetailsTools.m
//  WisdomCommunity
//
//  Created by bridge on 17/3/17.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ActivityDetailsTools.h"

@implementation ActivityDetailsTools

//根据属性获取label大小
+ (CGSize) getAttributeSizeWithLabel:(UILabel *)textLabel
{
    CGSize maximumLabelSize = CGSizeMake(CYScreanW - 20, 9999);
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    return expectSize;
}
//根据文本获取label大小
+ (CGSize) getSizeWithText:(NSString *)text font:(UIFont *)fnt
{
    if (IOS7) {
        CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(CYScreanW * 0.94, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
        return tmpRect.size;
    }else{
        
        CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
        return size;
    }
}
//计算包含表情的字符串高度
+ (float) calculate:(NSString *) string
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)[CYSmallTools textEditing:string]);
    CGSize targetSize = CGSizeMake(CYScreanW, CGFLOAT_MAX);
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, (CFIndex)[[CYSmallTools textEditing:string] length]), NULL, targetSize, NULL);
    CFRelease(framesetter);
    return size.height;
}
/// 使用颜色填充图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}
//字符串转utf-8
+ (NSString *) StrTurnToUTF:(NSString *) content
{
    return [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
//utf-8转字符串
+ (NSString *) UTFTurnToStr:(NSString *) conten
{
    NSLog(@"conten = %@",conten);
    
    if ([@"<null>" isEqualToString:conten] || [[NSNull null] isEqual:conten]) {
        return [@"" stringByRemovingPercentEncoding];
    }
    else
        return [conten stringByRemovingPercentEncoding];
}
//获取表情个数
+ (NSInteger)stringContainsEmoji:(NSString* )string
{
//    __block BOOL returnValue = NO;
    __block NSInteger number = 0;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if ((0x1d000 <= uc && uc <= 0x1f77f) || (0x1F900 <= uc && uc <=0x1f9ff)){
//                    returnValue = YES;
                    number += 1;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
//                returnValue = YES;
                number += 1;
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
//                returnValue = YES;
                number += 1;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
//                returnValue = YES;
                number += 1;
            } else if (0x2934 <= hs && hs <= 0x2935) {
//                returnValue = YES;
                number += 1;
            } else if (0x3297 <= hs && hs <= 0x3299) {
//                returnValue = YES;
                number += 1;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
//                returnValue = YES;
                number += 1;
            }else if (hs == 0x200d){
//                returnValue = YES;
                number += 1;
            }
        }
    }];
    return number;
}


//比较时间
+ (NSString *)returnStateString:(NSString *)acTime
{
    if (acTime == nil) {
        return nil;
    }
    NSArray *actimeArray = [acTime componentsSeparatedByString:@"~"];
    NSString *starTimer = [actimeArray firstObject];
    NSString *endTimer = [actimeArray lastObject];
    NSDate *date = [NSDate date]; // 获得时间对象
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [forMatter stringFromDate:date];
    NSLog(@"当前时间%@,",dateStr);
    if ([[self compareOneDaya:dateStr withAnotherDay:starTimer] isEqualToString:@"-1"]) {
        //活动尚未开始
        return @"Not";
    }else{
        if ([[self compareOneDaya:dateStr withAnotherDay:endTimer] isEqualToString:@"1"]) {
            //活动已经结束
            return @"end";
        }else{
            //活动正在进行
            return @"start";
        }
    }
}
//比较时间大小
+ (NSString *)compareOneDaya:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-dd-MM"];
    NSComparisonResult result = [oneDayStr compare:anotherDayStr];
    NSLog(@"oneDayStr = %@,anotherDayStr = %@",oneDayStr,anotherDayStr);
    
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        //日期one大
        return @"1";
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        //日期one小
        return @"-1";
    }
    //NSLog(@"Both dates are the same");
    return @"0";
    
}
//设置图片高
+ (float) getPictureHeight:(NSString *)path
{
    //获取图片大小
    NSData *imageData = [CYSmallTools GetCashUrl:path];
    CGSize size;
    if (imageData)
    {
        size = [UIImage imageWithData:imageData].size;
    }
    else
        size = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]].size;
    //比较宽度
    if (size.width > (CYScreanW - 20))
    {
        return (CYScreanW - 20) / size.width * size.height;
    }
    else
    {
        return  size.width / (CYScreanW - 20) * size.height;
    }
    
}
//图片缩放
+ (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale
{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    UIGraphicsBeginImageContext(size); // this will crop
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
