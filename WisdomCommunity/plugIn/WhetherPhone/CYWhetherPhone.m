//
//  WhetherPhone.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CYWhetherPhone.h"

@implementation CYWhetherPhone
// 判断是否是手机号
+ (BOOL)isValidPhone:(NSString *)phone
{
    if (phone.length != 11)
    {
        return NO;
    }
    else
    {
//        /**
//         * 移动号段正则表达式
//         */
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//        /**
//         * 联通号段正则表达式
//         */
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//        /**
//         * 电信号段正则表达式
//         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:phone];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:phone];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        BOOL isMatch3 = [pred3 evaluateWithObject:phone];
//        
//        if (isMatch1 || isMatch2 || isMatch3)
//        {
//            return YES;
//        }
//        else
//        {
//            return NO;
//        }
        NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        return [phoneTest evaluateWithObject:phone];
    }
}
//判断是不是只有数字和字母
+ (BOOL) judgePassword:(NSString *)pwdStr
{
    NSString *string = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", string];
    return [pred evaluateWithObject:pwdStr];
}
@end
