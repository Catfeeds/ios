//
//  WXForgetPasswordTwoVC.m
//  caxjh
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018年 Yingchao Zou. All rights reserved.
//

#import "WXForgetPasswordTwoVC.h"
#import "WXLoginInputView.h"
#import <CommonCrypto/CommonDigest.h>
#import "WXPasswordLoginVC.h"
#import "WXTool.h"

@interface WXForgetPasswordTwoVC ()<UITextFieldDelegate>
@property (nonatomic, readwrite, strong) UIImageView *logoImageView;
@property (nonatomic, readwrite, strong) WXLoginInputView *loginInputView1;
@property (nonatomic, readwrite, strong) WXLoginInputView *loginInputView2;
@property (nonatomic, readwrite, strong) UIButton *loginButton;
@end

@implementation WXForgetPasswordTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
    [self setupUI];
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
-(void)didTouchPasswordSee1{
    if (self.loginInputView1.textFieldAccount.secureTextEntry == YES) {
        self.loginInputView1.textFieldAccount.secureTextEntry = NO;
        [_loginInputView1.arrowButton setImage:[UIImage imageNamed:@"login_password_see"] forState:UIControlStateNormal];
    }else{
        self.loginInputView1.textFieldAccount.secureTextEntry = YES;
        [_loginInputView1.arrowButton setImage:[UIImage imageNamed:@"login_password_noSee"] forState:UIControlStateNormal];
    }
}
-(void)didTouchPasswordSee2{
    if (self.loginInputView2.textFieldAccount.secureTextEntry == YES) {
        self.loginInputView2.textFieldAccount.secureTextEntry = NO;
        [_loginInputView2.arrowButton setImage:[UIImage imageNamed:@"login_password_see"] forState:UIControlStateNormal];
    }else{
        self.loginInputView2.textFieldAccount.secureTextEntry = YES;
        [_loginInputView2.arrowButton setImage:[UIImage imageNamed:@"login_password_noSee"] forState:UIControlStateNormal];
    }
}
-(void)didTouchLoginButton{
    if ([WXTool checkPassword:self.loginInputView1.textFieldAccount.text] == NO) {
        [self.view makeToast:@"请输入6-16位的数字字母的密码" duration:1.0 position:CSToastPositionTop];
        return ;
    }
    if ([WXTool checkPassword:self.loginInputView2.textFieldAccount.text] == NO) {
        [self.view makeToast:@"请输入6-16位的数字字母的密码" duration:1.0 position:CSToastPositionTop];
        return ;
    }
    if (![self.loginInputView1.textFieldAccount.text isEqualToString:self.loginInputView2.textFieldAccount.text]) {
        [self.view makeToast:@"密码与确认密码不一致" duration:1.0 position:CSToastPositionTop];
        return ;
    }
    [SVProgressHUD show];
    NSDictionary *params = @{@"mobile":self.phone,@"password":@"",@"client":@"ios",@"log_type":self.code,@"captcha":self.loginInputView1.textFieldAccount.text};
    [WXAFNetworkCore postHttpRequestWithURL:kAPILoginURL params:params succeedBlock:^(id responseObj) {
        [SVProgressHUD dismiss];
        ResponseModel *response = [ResponseModel mj_objectWithKeyValues:responseObj];
        [self.loginInputView1.textFieldAccount resignFirstResponder];
        if ([response.code isEqualToString:@"200"]) {
            [self.view makeToast:@"重置密码成功" duration:1.0 position:CSToastPositionTop];
            [self performSelector:@selector(pop) withObject:nil afterDelay:1];
        } else {
            [self.view makeToast:response.message duration:1.0 position:CSToastPositionTop];
        }
    } failBlock:^(id error) {
        [SVProgressHUD dismiss];
        [self.loginInputView1.textFieldAccount resignFirstResponder];
        NSLog(@"%@",error);
    }];
}
- (void)pop {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[WXPasswordLoginVC class]]) {
            WXPasswordLoginVC *vc =(WXPasswordLoginVC *)controller;
            [self.navigationController popToViewController:vc animated:YES];
        }
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
        _loginInputView1.textFieldAccount.placeholder = @"请输入6-16位的数字字母";
        _loginInputView1.textFieldAccount.delegate = self;
        _loginInputView1.textFieldAccount.secureTextEntry = YES;
        //_loginInputView1.textFieldAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
        _loginInputView1.imageViewCode.image = [UIImage imageNamed:@"login_password"];
         [_loginInputView1.arrowButton setImage:[UIImage imageNamed:@"login_password_noSee"] forState:UIControlStateNormal];
        [_loginInputView1.arrowButton addTarget:self action:@selector(didTouchPasswordSee1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginInputView1;
}
- (WXLoginInputView *)loginInputView2{
    if (!_loginInputView2) {
        _loginInputView2 = [[WXLoginInputView alloc] init];
        _loginInputView2.textFieldAccount.placeholder = @"请再次输入密码";
        _loginInputView2.textFieldAccount.secureTextEntry = YES;
        _loginInputView2.textFieldAccount.delegate = self;
        _loginInputView2.imageViewCode.image = [UIImage imageNamed:@"login_password"];
         [_loginInputView2.arrowButton setImage:[UIImage imageNamed:@"login_password_noSee"] forState:UIControlStateNormal];
        [_loginInputView2.arrowButton addTarget:self action:@selector(didTouchPasswordSee2) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginInputView2;
}
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.showsTouchWhenHighlighted = NO;
        [_loginButton setTitle:@"完成" forState:UIControlStateNormal];
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
