//
//  WXCaptchaLoginVC.m
//  caxjh
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018年 Yingchao Zou. All rights reserved.
//

#import "WXCaptchaLoginVC.h"
#import "WXLoginInputView.h"


@interface WXCaptchaLoginVC ()<UITextFieldDelegate>
@property (nonatomic, readwrite, strong) UIImageView *logoImageView;
@property (nonatomic, readwrite, strong) WXLoginInputView *loginInputView1;
@property (nonatomic, readwrite, strong) WXLoginInputView *loginInputView2;
@property (nonatomic, readwrite, strong) UIButton *loginButton;
@property (nonatomic, readwrite, strong) UIButton *passwordButton;
@property (nonatomic ,strong)UIButton *protocolBtn;

@property (nonatomic, readwrite, strong) NSTimer *codeTimer;
@property (nonatomic, readwrite, assign) NSUInteger codeTime;
@end

@implementation WXCaptchaLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self.passwordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.top.equalTo(self.loginButton.mas_bottom).with.offset(10);
        make.height.equalTo(@44);
    }];
    [self.protocolBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-15);
        make.centerX.equalTo(self.view);
    }];
}
#pragma mark---事件
//协议
-(void)didTouchProtocolButton{
    
}
-(void)didtouchRightButton:(UIButton *)sender{
    WXPasswordLoginVC *vc = [[WXPasswordLoginVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self.delegate;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)didTouchGetCapatcha{
//    if (self.loginInputView1.textFieldAccount.text.length != 11) {
//        [self.view makeToast:@"请输入正确的手机号码" duration:1 position:CSToastPositionTop];
//    }else{
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        NSDictionary *dictionary = @{@"phone":self.loginInputView1.textFieldAccount.text, @"mode":@"login"};
//        [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
//        [PPNetworkHelper POST:kAPICaptchaURL parameters:dictionary success:^(id responseObject) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            XJHCaptchaResponse *response = [XJHCaptchaResponse mj_objectWithKeyValues:responseObject];
//            if ([response.type isEqualToString:@"success"]) {
//                [self startCountTime];
//                [self.view makeToast:response.content duration:1.0 position:CSToastPositionTop];
//            } else {
//                [self.view makeToast:response.content duration:1.0 position:CSToastPositionTop];
//            }
//
//        } failure:^(NSError *error) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        }];
//    }
}
- (void)startCountTime {
    self.codeTime = 60;
    
    self.loginInputView2.arrowButton.enabled = NO;
    UIBackgroundTaskIdentifier bgTask = UIBackgroundTaskInvalid;
    UIApplication *app = [UIApplication sharedApplication];
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
    }];
    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.codeTimer forMode:NSRunLoopCommonModes];
}
- (void)update {
    
    if (self.codeTime == 0) {
        self.loginInputView2.arrowButton.enabled = YES;
        [self.loginInputView2.arrowButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        return;
    }
    [self.loginInputView2.arrowButton setTitle:[NSString stringWithFormat:@"    %lds    ", (long)self.codeTime] forState:UIControlStateNormal];
    self.codeTime--;
    
}

-(void)didDeleteBtnAction{
    self.loginInputView1.textFieldAccount.text = @"";
}
-(void)didTouchLoginButton{
    if (self.loginInputView1.textFieldAccount.text.length != 11) {
//        [self.view makeToast:@"请输入正确的手机号码" duration:1 position:CSToastPositionTop];
        return;
    }
    if(self.loginInputView2.textFieldAccount.text.length!=4){
//        [self.view makeToast:@"请输入正确的短信验证码" duration:1 position:CSToastPositionTop];
        return;
    }
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSDictionary *dictionary = @{@"phone" : self.loginInputView1.textFieldAccount.text, @"password" : self.loginInputView2.textFieldAccount.text,@"type":@"phone"};
//    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
//    [PPNetworkHelper POST:kAPILoginURL parameters:dictionary success:^(id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//        XJHLoginResponse *loginResponse = [XJHLoginResponse mj_objectWithKeyValues:responseObject];
//
//        if ([loginResponse.type isEqualToString:@"success"]) {
//
//            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"id"] forKey:@"USER_ID"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            [[NSUserDefaults standardUserDefaults] setObject:self.loginInputView1.textFieldAccount.text forKey:@"USER_PHONE"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            NSString *userDataPhone = responseObject[@"data"][@"phone"];
//            userDataPhone = [userDataPhone isEqual:[NSNull null]] ? @"" : userDataPhone;
//            [[NSUserDefaults standardUserDefaults] setObject:userDataPhone forKey:@"USER_DATA_PHONE"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            NSString *userDataLoginName = responseObject[@"data"][@"loginName"];
//            userDataLoginName = [userDataLoginName isEqual:[NSNull null]] ? @"" : userDataLoginName;
//            [[NSUserDefaults standardUserDefaults] setObject:userDataLoginName forKey:@"USER_DATA_LOGINNAME"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            // 0主账户 1子账户
//            NSString *userDataIsMain = responseObject[@"data"][@"isMain"];
//            userDataIsMain = [userDataIsMain isEqual:[NSNull null]] ? @"" : userDataIsMain;
//            [[NSUserDefaults standardUserDefaults] setObject:userDataIsMain forKey:@"USER_DATA_ISMAIN"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            // 0老师 1家长 2学生
//            NSString *userDataType = responseObject[@"data"][@"type"];
//            userDataType = [userDataType isEqual:[NSNull null]] ? @"" : userDataType;
//            [[NSUserDefaults standardUserDefaults] setObject:userDataType forKey:@"USER_DATA_TYPE"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            NSString *userDataToken = responseObject[@"data"][@"token"];
//            userDataToken = [userDataToken isEqual:[NSNull null]] ? @"" : userDataToken;
//            [[NSUserDefaults standardUserDefaults] setObject:userDataToken forKey:@"USER_DATA_TOKEN"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            NSString *userNickName = responseObject[@"data"][@"nickName"];
//            userNickName = [userDataPhone isEqual:[NSNull null]] ? @"" : userDataPhone;
//            if (userNickName.length > 0) {
//                [[NSUserDefaults standardUserDefaults] setObject:userDataPhone forKey:@"USER_DATA_NAME"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
//            //绑定孩子
//            [[NSUserDefaults standardUserDefaults] setObject:@{@"name":@""} forKey:STUENDTS_SELECT];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            [self.view makeToast:@"登录成功" duration:1.0 position:CSToastPositionTop];
//            [self performSelector:@selector(navigateToTab) withObject:nil afterDelay:2.0];
//        } else {
//            [self.view makeToast:loginResponse.content duration:1.0 position:CSToastPositionTop];
//        }
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
}
                                             
#pragma mark -
- (void)navigateToTab {
    if (self.delegate && [self.delegate respondsToSelector:@selector(toTab)]) {
        [self.delegate toTab];
    }
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
        return textField.text.length < 4;
    }
    return YES;
}

#pragma mark---UI
-(void)setupUI{
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginInputView1];
    [self.view addSubview:self.loginInputView2];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.passwordButton];
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
        _loginInputView1.textFieldAccount.placeholder = @"请输入手机号";
        _loginInputView1.textFieldAccount.delegate = self;
        _loginInputView1.textFieldAccount.keyboardType = UIKeyboardTypeNumberPad;
        //_loginInputView1.textFieldAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
        _loginInputView1.imageViewCode.image = [UIImage imageNamed:@"login_account"];
        [_loginInputView1.arrowButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
        [_loginInputView1.arrowButton addTarget:self action:@selector(didDeleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginInputView1;
}
- (WXLoginInputView *)loginInputView2{
    if (!_loginInputView2) {
        _loginInputView2 = [[WXLoginInputView alloc] init];
        _loginInputView2.textFieldAccount.keyboardType = UIKeyboardTypeNumberPad;
        _loginInputView2.textFieldAccount.placeholder = @"请输入验证码";
        _loginInputView2.textFieldAccount.delegate = self;
        _loginInputView2.imageViewCode.image = [UIImage imageNamed:@"login_password"];
        [_loginInputView2.arrowButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_loginInputView2.arrowButton setBorder:selectedTexColor width:1];
        _loginInputView2.arrowButton.radius = 15;
        [_loginInputView2.arrowButton addTarget:self action:@selector(didTouchGetCapatcha) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginInputView2;
}
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.showsTouchWhenHighlighted = NO;
        [_loginButton setTitle:@"验证并登录" forState:UIControlStateNormal];
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
- (UIButton *)passwordButton {
    if (!_passwordButton) {
        _passwordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _passwordButton.showsTouchWhenHighlighted = NO;
        [_passwordButton setTitle:@"密码登录" forState:UIControlStateNormal];
        _passwordButton.titleLabel.font = kFont(14);
        [_passwordButton setTitleColor:selectedTexColor forState:UIControlStateNormal];
        [_passwordButton setTitleColor:selectedTexColor forState:UIControlStateHighlighted];
        [_passwordButton setBackgroundColor:[UIColor colorWithHex:@"#ffffff"]];
        _passwordButton.layer.cornerRadius = 22;
        _passwordButton.layer.masksToBounds = YES;
        [_passwordButton setBorder:selectedTexColor width:1];
        [_passwordButton addTarget:self action:@selector(didTouchLoginButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordButton;
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
