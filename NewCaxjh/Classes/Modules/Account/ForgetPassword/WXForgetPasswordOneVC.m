//
//  WXForgetPasswordOneVC.m
//  caxjh
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018年 Yingchao Zou. All rights reserved.
//

#import "WXForgetPasswordOneVC.h"
#import "WXLoginInputView.h"
#import "WXForgetPasswordTwoVC.h"

@interface WXForgetPasswordOneVC ()<UITextFieldDelegate>
@property (nonatomic, readwrite, strong) UIImageView *logoImageView;
@property (nonatomic, readwrite, strong) WXLoginInputView *loginInputView1;
@property (nonatomic, readwrite, strong) WXLoginInputView *loginInputView2;
@property (nonatomic, readwrite, strong) UIButton *loginButton;

@property (nonatomic, readwrite, strong) NSTimer *codeTimer;
@property (nonatomic, readwrite, assign) NSUInteger codeTime;

@property (nonatomic ,copy)NSString *log_type;
@end

@implementation WXForgetPasswordOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找回密码";
    [self setUpRightBarButtonItemWithTitle:@"联系客服"];
    [self.rightBarItem setTitleColor:selectedTexColor forState:UIControlStateNormal];
    
    [self setupUI];
    
    self.log_type = @"sms_password_reset";
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
}
#pragma mark---事件
-(void)didtouchRightButton:(UIButton *)sender{
    NSString *phoneNumber = [@"tel:" stringByAppendingString:@"010-6938-3422"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
-(void)didTouchGetCapatcha{
    if (self.loginInputView1.textFieldAccount.text.length != 11) {
        [self.view makeToast:@"请输入正确的手机号码" duration:1 position:CSToastPositionTop];
        return;
    }
    [SVProgressHUD show];
    NSDictionary *params = @{@"mobile":self.loginInputView1.textFieldAccount.text, @"type":@"3"};
    [WXAFNetworkCore postHttpRequestWithURL:kAPIGetCaptchaURL params:params succeedBlock:^(id responseObj) {
        [SVProgressHUD dismiss];
        ResponseModel *response = [ResponseModel mj_objectWithKeyValues:responseObj];
        [self.loginInputView1.textFieldAccount resignFirstResponder];
        if ([response.code isEqualToString:@"200"]) {
            [self startCountTime];
            [self.view makeToast:@"短信发送成功" duration:1.0 position:CSToastPositionTop];
            NSDictionary *dic = response.result;
            self.log_type = dic[@"type"];
        } else {
            [self.view makeToast:response.message duration:1.0 position:CSToastPositionTop];
        }
    } failBlock:^(id error) {
        [SVProgressHUD dismiss];
        [self.loginInputView1.textFieldAccount resignFirstResponder];
        NSLog(@"%@",error);
    }];
}
-(void)didDeleteBtnAction{
    self.loginInputView1.textFieldAccount.text = @"";
}
//验证验证码
-(void)didTouchLoginButton{
    if (self.loginInputView1.textFieldAccount.text.length != 11) {
        [self.view makeToast:@"请输入正确的手机号码" duration:1 position:CSToastPositionTop];
        return;
    }
    if(self.loginInputView2.textFieldAccount.text.length != 6){
        [self.view makeToast:@"请输入正确的短信验证码" duration:1 position:CSToastPositionTop];
        return;
    }
    [SVProgressHUD show];
    NSDictionary *params = @{@"mobile":self.loginInputView1.textFieldAccount.text, @"log_type":self.log_type,@"captcha":self.loginInputView2.textFieldAccount.text};
    [WXAFNetworkCore postHttpRequestWithURL:kAPICheckCaptchaURL params:params succeedBlock:^(id responseObj) {
        [SVProgressHUD dismiss];
        ResponseModel *response = [ResponseModel mj_objectWithKeyValues:responseObj];
        [self.loginInputView1.textFieldAccount resignFirstResponder];
        if ([response.code isEqualToString:@"200"]) {
            WXForgetPasswordTwoVC *vc = [[WXForgetPasswordTwoVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.phone = self.loginInputView1.textFieldAccount.text;
            vc.code = self.log_type;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view makeToast:response.message duration:1.0 position:CSToastPositionTop];
        }
    } failBlock:^(id error) {
        [SVProgressHUD dismiss];
        [self.loginInputView1.textFieldAccount resignFirstResponder];
        NSLog(@"%@",error);
    }];
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
#pragma mark--textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length == 1 && string.length == 0) {
        return YES;
    }
    else if ([textField isEqual:self.loginInputView1.textFieldAccount] && ![string isEqualToString:@""]) {
        return textField.text.length < 11;
    }
    else if ([textField isEqual:self.loginInputView2.textFieldAccount] && ![string isEqualToString:@""]) {
        return textField.text.length < 6;
    }
    return YES;
}
#pragma mark---UI
-(void)setupUI{
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginInputView1];
    [self.view addSubview:self.loginInputView2];
    [self.view addSubview:self.loginButton];
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
        _loginInputView2.textFieldAccount.placeholder = @"请输入验证码";
        _loginInputView2.textFieldAccount.delegate = self;
        _loginInputView2.imageViewCode.image = [UIImage imageNamed:@"login_password"];
        [_loginInputView2.arrowButton setTitle:@" 获取验证码 " forState:UIControlStateNormal];
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
        [_loginButton setTitle:@"下一步" forState:UIControlStateNormal];
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
