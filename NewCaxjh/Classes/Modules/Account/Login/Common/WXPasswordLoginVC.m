//
//  WXPasswordLoginVC.m
//  caxjh
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018年 Yingchao Zou. All rights reserved.
//

#import "WXPasswordLoginVC.h"
#import "WXLoginInputView.h"
#import "WXForgetPasswordOneVC.h"
#import <CommonCrypto/CommonDigest.h>
#import "WXTool.h"


@interface WXPasswordLoginVC ()<UITextFieldDelegate>
@property (nonatomic, readwrite, strong) UIImageView *logoImageView;
@property (nonatomic, readwrite, strong) WXLoginInputView *loginInputView1;
@property (nonatomic, readwrite, strong) WXLoginInputView *loginInputView2;
@property (nonatomic, readwrite, strong) UIButton *loginButton;
@property (nonatomic ,strong)UIButton *protocolBtn;
@end

@implementation WXPasswordLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"密码登录";
    [self setUpRightBarButtonItemWithTitle:@"忘记密码"];
    [self.rightBarItem setTitleColor:selectedTexColor forState:UIControlStateNormal];
    [self setupUI];
    self.loginInputView1.textFieldAccount.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_PHONE"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(60);
    }];
    [self.loginInputView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.top.equalTo(self.logoImageView.mas_bottom).with.offset(70);
        make.left.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view).with.offset(-30);
    }];
    [self.loginInputView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.top.equalTo(self.loginInputView1.mas_bottom).with.offset(40);
        make.left.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view).with.offset(-30);
    }];
    [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.top.equalTo(self.loginInputView2.mas_bottom).with.offset(45);
        make.height.equalTo(@44);
    }];
    if (IS_IPhoneX_All) {
        [self.protocolBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).with.offset(-34);
            make.centerX.equalTo(self.view);
        }];
    }else{
        [self.protocolBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).with.offset(-15);
            make.centerX.equalTo(self.view);
        }];
    }
}
#pragma mark---事件
//协议
-(void)didTouchProtocolButton{
    
}
//忘记密码
-(void)didtouchRightBarItem:(UIButton *)sender{
    WXForgetPasswordOneVC *vc = [[WXForgetPasswordOneVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)didTouchPasswordSee{
    if (self.loginInputView2.textFieldAccount.secureTextEntry == YES) {
        self.loginInputView2.textFieldAccount.secureTextEntry = NO;
        [_loginInputView2.arrowButton setImage:[UIImage imageNamed:@"login_password_see"] forState:UIControlStateNormal];
    }else{
        self.loginInputView2.textFieldAccount.secureTextEntry = YES;
        [_loginInputView2.arrowButton setImage:[UIImage imageNamed:@"login_password_noSee"] forState:UIControlStateNormal];
    }
}
-(void)didDeleteBtnAction{
    self.loginInputView1.textFieldAccount.text = @"";
}
-(void)didTouchLoginButton{
    
    if (self.loginInputView1.textFieldAccount.text.length == 0) {
        [self.view makeToast:@"账号不能为空" duration:1.0 position:CSToastPositionTop];
        return ;
    }
    if ([WXTool checkPassword:self.loginInputView2.textFieldAccount.text] == NO) {
        [self.view makeToast:@"请输入6-16位的数字字母的密码" duration:1.0 position:CSToastPositionTop];
        return ;
    }
    NSDictionary *params = @{@"mobile":self.loginInputView1.textFieldAccount.text,@"password":self.loginInputView2.textFieldAccount.text,@"client":@"ios",@"log_type":@"sms_login",@"captcha":@"",@"is_pass":@"1"};
    [WXAFNetworkCore postHttpRequestWithURL:kAPILoginURL params:params succeedBlock:^(id responseObj) {
        [SVProgressHUD dismiss];
        NSString *string = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        ResponseModel *response = [ResponseModel mj_objectWithKeyValues:responseObj];
        [self.loginInputView1.textFieldAccount resignFirstResponder];
        if ([response.code isEqualToString:@"200"]) {
            [self.view makeToast:@"登录/注册成功" duration:1.0 position:CSToastPositionTop];
            //用户信息存储
            NSDictionary *dic = response.result;
            //id
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"uid"] forKey:@"USER_ID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //手机号
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"member_mobile"] forKey:@"USER_PHONE"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //token
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"key"] forKey:@"USER_TOKEN"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //头像
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"avator"] forKey:@"USER_HeaderImage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //用户名
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"is_owner"] forKey:@"USER_IsOwner"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //主账号
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"viceAccount"] forKey:@"USER_ViceAccount"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //副账号
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"viceAccount"] forKey:@"USER_ViceAccount"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //用户类型：1家长，2老师，3其他未知
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"member_identity"] forKey:@"USER_TYPE"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //跳转主页面
            [self performSelector:@selector(navigateToTab) withObject:nil afterDelay:1.0];
        } else {
            [self.view makeToast:response.message];
        }
    } failBlock:^(id error) {
        [SVProgressHUD dismiss];
        [self.loginInputView1.textFieldAccount resignFirstResponder];
        NSLog(@"%@",error);
    }];
    
}
#pragma mark -
- (void)navigateToTab {
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotificationName object:nil];
}
#pragma mark--textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length == 1 && string.length == 0) {
        return YES;
    }
    else if ([textField isEqual:self.loginInputView1.textFieldAccount] && ![string isEqualToString:@""]) {
        return textField.text.length < 11;
    }
    else if ([textField isEqual:self.loginInputView2.textFieldAccount] && ![string isEqualToString:@""]) {
        return textField.text.length < 16;
    }
    return YES;
}
#pragma mark---UI
-(void)setupUI{
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginInputView1];
    [self.view addSubview:self.loginInputView2];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.protocolBtn];
}
- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"LaunchScreen"];
    }
    return _logoImageView;
}
- (WXLoginInputView *)loginInputView1{
    if (!_loginInputView1) {
        _loginInputView1 = [[WXLoginInputView alloc] init];
        _loginInputView1.textFieldAccount.keyboardType = UIKeyboardTypeNumberPad;
        _loginInputView1.textFieldAccount.placeholder = @"请输入手机号";
        _loginInputView1.textFieldAccount.delegate = self;
        _loginInputView1.textFieldAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
        _loginInputView1.imageViewCode.image = [UIImage imageNamed:@"login_account"];
        [_loginInputView1.arrowButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
        [_loginInputView1.arrowButton addTarget:self action:@selector(didDeleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginInputView1;
}
- (WXLoginInputView *)loginInputView2{
    if (!_loginInputView2) {
        _loginInputView2 = [[WXLoginInputView alloc] init];
        _loginInputView2.textFieldAccount.placeholder = @"请输入密码";
        _loginInputView2.textFieldAccount.delegate = self;
        _loginInputView2.textFieldAccount.secureTextEntry = YES;
        _loginInputView2.imageViewCode.image = [UIImage imageNamed:@"login_password"];
        [_loginInputView2.arrowButton setImage:[UIImage imageNamed:@"login_password_noSee"] forState:UIControlStateNormal];
        [_loginInputView2.arrowButton addTarget:self action:@selector(didTouchPasswordSee) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginInputView2;
}
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.showsTouchWhenHighlighted = NO;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = kFont(14);
        [_loginButton setTitleColor:[UIColor colorWithHex:@"#ffffff"] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor colorWithHex:@"#ffffff"] forState:UIControlStateHighlighted];
        [_loginButton setBackgroundColor:selectedTexColor];
        _loginButton.layer.cornerRadius = 22;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton addTarget:self action:@selector(didTouchLoginButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
- (UIButton *)protocolBtn {
    if (!_protocolBtn) {
        NSString *text = @"登录即表示同意《服务协议》";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
        [str addAttribute:NSForegroundColorAttributeName value:defaultTextColor range:NSMakeRange(0,7)];
        [str addAttribute:NSForegroundColorAttributeName value:selectedTexColor range:NSMakeRange(7,text.length-7)];
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_protocolBtn setAttributedTitle:str forState:UIControlStateNormal];
        _protocolBtn.titleLabel.font = kFont(13);
        [_protocolBtn addTarget:self action:@selector(didTouchProtocolButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocolBtn;
}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
