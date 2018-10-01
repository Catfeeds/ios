//
//  RealNameInputView.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/29.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "RealNameInputView.h"

@implementation RealNameInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.promptLabel];
    [self addSubview:self.contentTextField];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.promptLabel.mas_right).offset(15);
        make.centerY.equalTo(self);
    }];
}
#pragma mark---懒加载
-(UILabel *)promptLabel{
    if (!_promptLabel) {
        _promptLabel = [UILabel new];
        _promptLabel.textColor = defaultTextColor;
        _promptLabel.font = kFont(15);
    }
    return _promptLabel;
}
-(UITextField *)contentTextField{
    if (!_contentTextField) {
        _contentTextField = [UITextField new];
        _contentTextField.textColor = defaultTextColor;
        _contentTextField.font = kFont(15);
    }
    return _contentTextField;
}
@end
