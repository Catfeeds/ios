//
//  UserWalletViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "UserWalletViewController.h"

@interface UserWalletViewController ()
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UIImageView *bgImgView;
@property (nonatomic ,strong)UILabel *accountPrompt;
@property (nonatomic ,strong)UILabel *accountLabel;
@property (nonatomic ,strong)UILabel *expirationPrompt;
@property (nonatomic ,strong)UILabel *expirationAccountLabel;

@property (nonatomic ,strong)UIView *detailView;
@property (nonatomic ,strong)UILabel *incomeLabel;
@property (nonatomic ,strong)UILabel *expenditureLabel;
@end

@implementation UserWalletViewController
#pragma mark---生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"钱包";
    [self setUpRightBarButtonItemWithTitle:@"明细"];
    [self.rightBarItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.view.backgroundColor = KbackgoundColor;
    //ui
    [self setupUI];
    
    //数据
    [self requestWalletData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = selectedTexColor;
    [self.popBarItem setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:18]}];
}
//布局
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //顶部
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.expirationAccountLabel.mas_bottom).offset(16);
    }];
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.bgView);
    }];
    
    [self.accountPrompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.equalTo(self.bgView);
    }];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountPrompt.mas_bottom).offset(46);
        make.centerX.equalTo(self.bgView);
    }];
    [self.expirationPrompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountLabel.mas_bottom).offset(46);
        make.centerX.equalTo(self.bgView);
    }];
    [self.expirationAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expirationPrompt.mas_bottom).offset(16);
        make.centerX.equalTo(self.bgView);
    }];
    //详情
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@78);
    }];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailView).offset(18);
        make.left.equalTo(self.view);
        make.width.equalTo(self.detailView).multipliedBy(0.5).offset(-5);
    }];
    [self.expenditureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailView).offset(18);
        make.right.equalTo(self.view);
        make.width.equalTo(self.detailView).multipliedBy(0.5).offset(-5);
    }];
    
}
#pragma mark---数据
-(void)requestWalletData{
    [SVProgressHUD show];
    [WXAFNetworkCore postHttpRequestWithURL:kAPIWalletDataURL params:nil succeedBlock:^(id responseObj) {
        [SVProgressHUD dismiss];
        ResponseModel *response = [ResponseModel mj_objectWithKeyValues:responseObj];
        if ([response.code isEqualToString:@"200"]) {
            NSDictionary *result = response.result;
            self.accountLabel.text = result[@"available_predeposit"];
            self.expirationAccountLabel.text = result[@"freeze_predeposit"];
            self.incomeLabel.text = result[@"income"];
            self.expenditureLabel.text = result[@"reflect"];
        } else {
            [self.view makeToast:response.message duration:1.0 position:CSToastPositionTop];
        }
    } failBlock:^(id error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
    }];
}

#pragma mark--setupUI
-(void)setupUI{
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.bgImgView];
    [self.bgView addSubview:self.accountPrompt];
    [self.bgView addSubview:self.accountLabel];
    [self.bgView addSubview:self.expirationPrompt];
    [self.bgView addSubview:self.expirationAccountLabel];
    
    //详情
    [self setupDetailView];
}
-(void)setupDetailView{
    [self.view addSubview:self.detailView];
    [self.detailView addSubview:self.incomeLabel];
    //支出
    [self.detailView addSubview:self.expenditureLabel];
    
    //收入提示
    UILabel *incomePrompt = [UILabel new];
    incomePrompt.text = @"收入";
    incomePrompt.textColor = grayTexColor;
    incomePrompt.font = kFont(13);
    incomePrompt.textAlignment = NSTextAlignmentCenter;
    [self.detailView addSubview:incomePrompt];
    
    //支出提示
    UILabel *expenditurePrompt = [UILabel new];
    expenditurePrompt.text = @"支出";
    expenditurePrompt.textColor = grayTexColor;
    expenditurePrompt.font = kFont(13);
    expenditurePrompt.textAlignment = NSTextAlignmentCenter;
    [self.detailView addSubview:expenditurePrompt];
    //支出图片
    UIImageView *imgV = [UIImageView new];
    imgV.image = [UIImage imageNamed:@"wallet_tx"];
    [self.detailView addSubview:imgV];
    
    UIView *separateLine = [UIView new];
    separateLine.backgroundColor = KLineColor;
    [self.detailView addSubview:separateLine];
    
    //布局
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.detailView);
        make.top.equalTo(self.detailView).offset(20);
        make.bottom.equalTo(self.detailView).offset(-20);
        make.width.equalTo(@3);
    }];
    [incomePrompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.detailView).offset(-13);
        make.centerX.equalTo(self.incomeLabel.mas_centerX);
    }];
    [expenditurePrompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.detailView).offset(-13);
        make.centerX.equalTo(self.expenditureLabel.mas_centerX);
    }];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(expenditurePrompt.mas_centerY);
        make.left.equalTo(expenditurePrompt.mas_right).offset(4);
    }];
}
#pragma mark--懒加载
-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView  = [UIView new];
        _bgView = bgView;
    }
    return _bgView;
}
-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        _bgImgView.image = [UIImage imageNamed:@"wallet_bg"];
    }
    return _bgImgView;
}
-(UILabel *)accountPrompt{
    if (!_accountPrompt) {
        _accountPrompt = [UILabel new];
        _accountPrompt.text = @"账户余额（元）";
        _accountPrompt.textColor = [UIColor whiteColor];
        _accountPrompt.font = kFontName(14, @"Helvetica-Bold");;
    }
    return _accountPrompt;
}
-(UILabel *)accountLabel{
    if (!_accountLabel) {
        _accountLabel = [UILabel new];
        _accountLabel.text = @"0.00";
        _accountLabel.textColor = [UIColor whiteColor];
        _accountLabel.font = kFontName(45, @"Helvetica-Bold");
    }
    return _accountLabel;
}
-(UILabel *)expirationPrompt{
    if (!_expirationPrompt) {
        _expirationPrompt = [UILabel new];
        _expirationPrompt.text = @"即将到账（元）";
        _expirationPrompt.textColor = [UIColor whiteColor];
        _expirationPrompt.font = kFontName(12, @"Helvetica-Bold");
    }
    return _expirationPrompt;
}
-(UILabel *)expirationAccountLabel{
    if (!_expirationAccountLabel) {
        _expirationAccountLabel = [UILabel new];
        _expirationAccountLabel.text = @"0.00元";
        _expirationAccountLabel.textColor = [UIColor whiteColor];
        _expirationAccountLabel.font = kFontName(12, @"Helvetica-Bold");;
    }
    return _expirationAccountLabel;
}
-(UIView *)detailView{
    if (!_detailView) {
        _detailView = [UIView new];
        _detailView.backgroundColor = [UIColor whiteColor];
    }
    return _detailView;
}
-(UILabel *)incomeLabel{
    if (!_incomeLabel) {
        _incomeLabel = [UILabel new];
        _incomeLabel.text = @"0.00";
        _incomeLabel.textColor = defaultTextColor;
        _incomeLabel.font = kFont(19);
        _incomeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _incomeLabel;
}
-(UILabel *)expenditureLabel{//支出
    if (!_expenditureLabel) {
        _expenditureLabel = [UILabel new];
        _expenditureLabel.text = @"0.00";
        _expenditureLabel.textColor = defaultTextColor;
        _expenditureLabel.font = kFont(19);
        _expenditureLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _expenditureLabel;
}

@end
