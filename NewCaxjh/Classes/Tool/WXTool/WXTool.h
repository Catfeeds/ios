//
//  WXTool.h
//  NewCaxjh
//
//  Created by Apple on 2018/9/29.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXTool : NSObject
#pragma mark---任何方式
+(BOOL)checkTextTypetTextStr:(NSString *)string WithTextType:(NSString *)type;
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;

#pragma 正则匹配邮箱
+ (BOOL)checkEmailNumber:(NSString *) emailNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;

#pragma 正则匹配数字
+ (BOOL)checkNum : (NSString *) numStr;

#pragma 正则匹配数字和小数点
+ (BOOL)checkNumAndSmallNum : (NSString *) numStr;

#pragma 正则匹配中文
+ (BOOL)checkChina : (NSString *) china;
#pragma 正则匹配中文姓名
+ (BOOL)checkChinaName : (NSString *) name;

#pragma 正则匹配字母
+ (BOOL)checkLetter : (NSString *) letter;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;

#pragma 正则匹银行卡号,16／19位的数字
+ (BOOL)checkBankCardNumber : (NSString *)cardNo;

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;
@end
