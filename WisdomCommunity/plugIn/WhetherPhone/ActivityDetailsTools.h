//
//  ActivityDetailsTools.h
//  WisdomCommunity
//
//  Created by bridge on 17/3/17.
//  Copyright © 2017年 bridge. All rights reserved.
//  活动详情页使用方法


#import <Foundation/Foundation.h>

@interface ActivityDetailsTools : NSObject
//根据属性获取label大小
+ (CGSize) getAttributeSizeWithLabel:(UILabel *)textLabel;

//根据文本获取label大小
+ (CGSize) getSizeWithText:(NSString *)text font:(UIFont *)fnt;

//计算包含表情的字符串高度
+ (float) calculate:(NSString *) string;

/// 使用颜色填充图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//字符串转utf-8
+ (NSString *) StrTurnToUTF:(NSString *) content;

//utf-8转字符串
+ (NSString *) UTFTurnToStr:(NSString *) conten;

//获取表情个数
+ (NSInteger)stringContainsEmoji:(NSString* )string;

//比较时间
+ (NSString *)returnStateString:(NSString *)acTime;

//获取图片的高
+ (float) getPictureHeight:(NSString *)path;
//图片缩放
+ (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale;
@end
