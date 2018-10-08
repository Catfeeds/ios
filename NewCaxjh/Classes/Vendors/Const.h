//
//  Const.h
//  NewCaxjh
//
//  Created by Apple on 2018/9/29.
//  Copyright © 2018年 Apple. All rights reserved.
//

#ifndef Const_h
#define Const_h

//正式服务器
#define BaseURL @"http://vip.xiangjianhai.com:8001/index.php/Wap"
//测试服务器
//#define BaseURL @"http://w.xjh.com/index.php/Wap"

//当前用户信息读取
#define UserID [[NSUserDefaults standardUserDefaults] stringForKey:@"USER_ID"]
#define UserToken [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_TOKEN"]
#define UserPhone [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_PHONE"]
#define USERHeaderImage [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_HeaderImage"]
//副账号
#define USER_ViceAccount  [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ViceAccount"]

//通知名称
#define LoginSuccessNotificationName  @"LoginSuccessNotificationName"
#define DropOutSuccessNotificationName  @"DropOutSuccessNotificationName"


/********************* 用户登录/注册 ********************************/
//发送短信验证码
#define kAPIGetCaptchaURL [NSString stringWithFormat:@"%@/Connect/get_sms_captcha.html",BaseURL]
//验证短信验证码接口
#define kAPICheckCaptchaURL [NSString stringWithFormat:@"%@/Connect/check_sms_captcha.html",BaseURL]
//登录
#define kAPILoginURL [NSString stringWithFormat:@"%@/login/dologin.html",BaseURL]

//注册
#define kAPIRegistURL [NSString stringWithFormat:@"%@/app/register",BaseURL]
//重置密码
#define kAPIForgetPassURL [NSString stringWithFormat:@"%@/login/password_reset.html",BaseURL]
//修改密码
//#define kAPIChangePassURL [NSString stringWithFormat:@"%@/webadmin/changePassword?token=%@&dt=0&u=%@",UserToken, currentMemberID]]

//设置页面-是否设置密码
//#define kAPISureSettingPassURL [NSString stringWithFormat:@"%@/app/verifyHasPassword?token=%@",BaseURL,UserToken]


/********************* 个人中心 ********************************/
//钱包
#define kAPIWalletDataURL [NSString stringWithFormat:@"%@/Member/self_assets.html?key=%@",BaseURL,UserToken]


/********************* 发现 ********************************/
//主页面
#define kAPIDiscoveryListURL [NSString stringWithFormat:@"%@/Common/navicon.html",BaseURL]










#endif /* Const_h */
