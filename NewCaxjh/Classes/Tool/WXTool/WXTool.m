//
//  WXTool.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/29.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "WXTool.h"

@implementation WXTool
#pragma mark---任何方式
+(BOOL)checkTextTypetTextStr:(NSString *)string WithTextType:(NSString *)type{
    NSString *pattern = type;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^(1[0-9])\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

#pragma 正则匹配邮箱
+ (BOOL)checkEmailNumber:(NSString *) emailNumber{
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:emailNumber];
    return isMatch;
}

#pragma 正则匹配用户密码6-20位数字和字母／符号组合
+ (BOOL)checkPassword:(NSString *) password
{
    //NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![^(0-9a-zA-Z)]+$)([^(0-9a-zA-Z)]|[a-zA-Z]|[0-9]){6,16}$";
    NSString *pattern = @"^[0-9a-zA-Z]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,3-16位的中文／英文／数字
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z0-9_\u4e00-\u9fa5]{3,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}

#pragma 正则匹配除字母，数字，汉字以外的特殊字符
+ (BOOL)checkIrregularCharacte : (NSString *) characte{
    NSString *pattern = @"/^[^\u4e00-\u9fa5a-zA-Z]+$/";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:characte];
    return isMatch;
}
#pragma 正则匹配数字
+ (BOOL)checkNum : (NSString *) numStr{
    NSString *pattern = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:numStr];
    return isMatch;
}
#pragma 正则匹配数字和小数点
+ (BOOL)checkNumAndSmallNum : (NSString *) numStr{
    NSString *pattern = @"^[0-9]{1,8}([.][0-9]{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:numStr];
    return isMatch;
}
#pragma 正则匹配中文
+ (BOOL)checkChina : (NSString *) china{
    NSString *pattern = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:china];
    return isMatch;
}
#pragma 正则匹配中文姓名
+ (BOOL)checkChinaName : (NSString *) name{
    NSString *pattern = @"^[\u4e00-\u9fa5]{2,5}+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:name];
    return isMatch;
}
#pragma 正则匹配字母
+ (BOOL)checkLetter : (NSString *) letter{
    NSString *pattern = @"^[a-zA-Z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:letter];
    return isMatch;
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}
#pragma 正则匹银行卡号,16／19位的数字
+ (BOOL)checkBankCardNumber : (NSString *)cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1]intValue];
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1; i >= 1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}
@end
