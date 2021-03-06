//
//  RealNameViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "RealNameViewController.h"
#import "RealNameInputView.h"

@interface RealNameViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UILabel *promptLabel;
@property (nonatomic ,strong)RealNameInputView *inputView1;
@property (nonatomic ,strong)RealNameInputView *inputView2;
@property (nonatomic ,weak)UIView *dividingLine;
@property (nonatomic ,strong)UIImageView *positiveImgV;
@property (nonatomic ,strong)UIImageView *negativeImgV;
@property (nonatomic ,strong)UIButton *positiveImgButton;
@property (nonatomic ,strong)UIButton *negativeImgButton;
@property (nonatomic ,strong)UIButton *uploadgButton;
@end

@implementation RealNameViewController
#pragma mark---生命周期
-(void)dealloc{
    NSLog(@"RealNameViewController-dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    //UI
    [self setupUI];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    [self.inputView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.promptLabel.mas_bottom);
        make.height.equalTo(@50);
    }];
    [self.inputView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.inputView1.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    [self.positiveImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dividingLine.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(20);
        make.width.equalTo(self.view).multipliedBy(0.5).offset(-25);
        make.height.equalTo(@100);
    }];
    [self.negativeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dividingLine.mas_bottom).offset(50);
        make.right.equalTo(self.view).offset(-20);
        make.width.equalTo(self.view).multipliedBy(0.5).offset(-25);
        make.height.equalTo(@100);
    }];
    [self.positiveImgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.positiveImgV.mas_bottom).offset(20);
        make.centerX.width.equalTo(self.positiveImgV);
        make.height.equalTo(@30);
    }];
    [self.negativeImgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.negativeImgV.mas_bottom).offset(20);
        make.centerX.width.equalTo(self.negativeImgV);
        make.height.equalTo(@30);
    }];
    
    [self.uploadgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.positiveImgButton.mas_bottom).offset(60);
        make.height.equalTo(@40);
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
    }];
    
}
#pragma mark---点击事件
-(void)touchUpUploadBtn{
    
}

#pragma mark---UI
-(void)setupUI{
    [self.view addSubview:self.promptLabel];
    [self.view addSubview:self.inputView1];
    [self.view addSubview:self.inputView2];
    //分割线
    UIView *dividingLine = [UIView new];
    dividingLine.backgroundColor = KbackgoundColor;
    [self.view addSubview:dividingLine];
    self.dividingLine = dividingLine;
    [dividingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView2.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@20);
    }];
    //bottom
    [self setupBottomView];
    
    [self.view addSubview:self.uploadgButton];
}
-(void)setupBottomView{
    //拍照提示
    UILabel *photoPrompt = [UILabel new];
    photoPrompt.textColor = defaultTextColor;
    photoPrompt.text = @"上传身份证反正面，注意反光，保证内容清晰";
    photoPrompt.font = kFont(10);
    [self.view addSubview:photoPrompt];
    [photoPrompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dividingLine.mas_bottom);
        make.left.equalTo(self.view).offset(20);
        make.height.equalTo(@50);
    }];
    
    [self.view addSubview:self.positiveImgV];
    [self.view addSubview:self.negativeImgV];
    [self.view addSubview:self.positiveImgButton];
    [self.view addSubview:self.negativeImgButton];

}
#pragma mark---懒加载
-(UILabel *)promptLabel{
    if (!_promptLabel) {
        _promptLabel = [UILabel new];
        _promptLabel.textColor = grayTexColor;
        _promptLabel.text = @"   实名认证用于确定身份是否真实有效，保证平台运营安全，请如实填写";
        _promptLabel.numberOfLines = 0;
        _promptLabel.font = kFont(10);
        _promptLabel.backgroundColor = KbackgoundColor;
    }
    return _promptLabel;
}
- (RealNameInputView *)inputView1{
    if (!_inputView1) {
        _inputView1 = [[RealNameInputView alloc] init];
        _inputView1.promptLabel.text = @"真实姓名";
        _inputView1.contentTextField.placeholder = @"输入真实姓名";
        _inputView1.contentTextField.delegate = self;
        _inputView1.contentTextField.returnKeyType = UIReturnKeyDone;
    }
    return _inputView1;
}
- (RealNameInputView *)inputView2{
    if (!_inputView2) {
        _inputView2 = [[RealNameInputView alloc] init];
        _inputView2.promptLabel.text = @"身份证号";
        _inputView2.contentTextField.placeholder = @"输入有效身份证件号";
        _inputView2.contentTextField.delegate = self;
        _inputView2.contentTextField.returnKeyType = UIReturnKeyDone;
    }
    return _inputView2;
}
- (UIImageView *)positiveImgV{
    if (!_positiveImgV) {
        _positiveImgV = [UIImageView new];
        _positiveImgV.backgroundColor = KLineColor;
    }
    return _positiveImgV;
}
-(UIImageView *)negativeImgV{
    if (!_negativeImgV) {
        _negativeImgV = [UIImageView new];
        _negativeImgV.backgroundColor = KLineColor;
    }
    return _negativeImgV;
}
- (UIButton *)positiveImgButton{
    if (!_positiveImgButton) {
        _positiveImgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_positiveImgButton setImage:[UIImage imageNamed:@"see_change"] forState:UIControlStateNormal];
        [_positiveImgButton setTitle:@"上传图片" forState:UIControlStateNormal];
        _positiveImgButton.titleLabel.font = kFont(14);
        [_positiveImgButton setTitleColor:selectedTexColor forState:UIControlStateNormal];
        [_positiveImgButton setBorder:selectedTexColor width:1.0];
        _positiveImgButton.radius = 5;
    }
    return _positiveImgButton;
}
- (UIButton *)negativeImgButton{
    if (!_negativeImgButton) {
        _negativeImgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_negativeImgButton setImage:[UIImage imageNamed:@"see_change"] forState:UIControlStateNormal];
        [_negativeImgButton setTitle:@"上传图片" forState:UIControlStateNormal];
        _negativeImgButton.titleLabel.font = kFont(14);
        [_negativeImgButton setTitleColor:selectedTexColor forState:UIControlStateNormal];
        [_negativeImgButton setBorder:selectedTexColor width:1.0];
        _negativeImgButton.radius = 5;
    }
    return _negativeImgButton;
}
- (UIButton *)uploadgButton{
    if (!_uploadgButton) {
        _uploadgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_uploadgButton setTitle:@"下一步" forState:UIControlStateNormal];
        _uploadgButton.titleLabel.font = kFont(16);
        [_uploadgButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_uploadgButton setBackgroundColor:selectedTexColor];
        [_uploadgButton addTarget:self action:@selector(touchUpUploadBtn) forControlEvents:UIControlEventTouchUpInside];
        [_uploadgButton setBorder:selectedTexColor width:1.0];
        _uploadgButton.radius = 20;
    }
    return _uploadgButton;
}
@end
