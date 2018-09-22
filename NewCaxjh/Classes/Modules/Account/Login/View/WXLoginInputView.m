//
//  WXLoginInputView.m
//  caxjh
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018年 Yingchao Zou. All rights reserved.
//

#import "WXLoginInputView.h"

@interface WXLoginInputView()
@property (nonatomic, readwrite, strong) UIView *line;
@end
@implementation WXLoginInputView
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.textFieldAccount];
        [self addSubview:self.line];
        [self addSubview:self.arrowButton];
        [self addSubview:self.imageViewCode];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imageViewCode mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@20);
        make.centerY.equalTo(self);
        make.left.equalTo(self);
    }];
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.imageViewCode.mas_right).offset(5);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@1);
    }];
    [self.arrowButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        //make.centerY.equalTo(self);
        make.bottom.equalTo(self.line.mas_top).offset(-1);
    }];
    [self.textFieldAccount mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageViewCode.mas_right).offset(5);
        make.right.equalTo(self.arrowButton.mas_left);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-2);
    }];

}
- (UIImageView *)imageViewCode {
    if (!_imageViewCode) {
        _imageViewCode = [[UIImageView alloc] init];
    }
    return _imageViewCode;
}

- (UITextField *)textFieldAccount {
    if (!_textFieldAccount) {
        _textFieldAccount = [[UITextField alloc] init];
        _textFieldAccount.userInteractionEnabled = YES;
        _textFieldAccount.font = kFont(14);
    }
    return _textFieldAccount;
}
- (UIButton *)arrowButton {
    if (!_arrowButton) {
        _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowButton setTitleColor:selectedTexColor forState:UIControlStateNormal];
        _arrowButton.titleLabel.font = kFont(14);
        _arrowButton.showsTouchWhenHighlighted = NO;
        _arrowButton.adjustsImageWhenHighlighted = NO;
    }
    return _arrowButton;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = KLineColor;
    }
    return _line;
}

@end
