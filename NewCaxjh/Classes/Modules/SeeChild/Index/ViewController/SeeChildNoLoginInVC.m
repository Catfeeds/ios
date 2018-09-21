//
//  SeeChildNoLoginInVC.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SeeChildNoLoginInVC.h"
#import "WXCaptchaLoginVC.h"

@interface SeeChildNoLoginInVC ()
@property (nonatomic ,strong)UIView *topView;
@property (nonatomic ,strong)UIImageView *noPlayImgV;

@property (nonatomic ,strong)UIImageView *placeholderImgV;
@property (nonatomic ,strong)UIButton *loginBtn;
@end

@implementation SeeChildNoLoginInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    [self setupUI];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.4);
    }];
    [self.noPlayImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.topView);
    }];
    [self.placeholderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(60);
        make.centerX.equalTo(self.topView);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeholderImgV.mas_bottom).offset(20);
        make.centerX.equalTo(self.placeholderImgV);
    }];
    
}
-(void)loginBtnAction{
    WXCaptchaLoginVC *vc = [[WXCaptchaLoginVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: vc animated:YES];
}
#pragma mark---UI
-(void)setupUI{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.noPlayImgV];
    [self.view addSubview:self.placeholderImgV];
    [self.view addSubview:self.loginBtn];
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor colorWithHex:@"#393939"];
    }
    return _topView;
}
-(UIImageView *)noPlayImgV{
    if (!_noPlayImgV) {
        _noPlayImgV = [UIImageView new];
        _noPlayImgV.image = [UIImage imageNamed:@"see_no_play"];
    }
    return _noPlayImgV;
}
- (UIImageView *)placeholderImgV{
    if (!_placeholderImgV) {
        _placeholderImgV = [UIImageView new];
        _placeholderImgV.image = [UIImage imageNamed:@"placeholder_no_login"];
    }
    return _placeholderImgV;
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.userInteractionEnabled = YES;
        [_loginBtn setTitleColor:grayTexColor forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = kFont(13);
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"您还未登录，点击 登录"];
        [string addAttribute:NSForegroundColorAttributeName value:grayTexColor range:NSMakeRange(0, string.length-2)];
        [string addAttribute:NSFontAttributeName value:kFont(13) range:NSMakeRange(string.length-2, 2)];
        [string addAttribute:NSForegroundColorAttributeName value:selectedTexColor range:NSMakeRange(string.length-2, 2)];
        [string addAttribute:NSFontAttributeName value:kFont(15) range:NSMakeRange(string.length-2, 2)];
        [_loginBtn setAttributedTitle:string forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
