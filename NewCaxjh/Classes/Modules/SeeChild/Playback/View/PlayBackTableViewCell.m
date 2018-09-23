//
//  PlayBackTableViewCell.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "PlayBackTableViewCell.h"

@implementation PlayBackTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
#pragma mark---setUI
-(void)setupUI{
    //基本属性
    self.textLabel.font = kFont(13);
    self.textLabel.textColor = defaultTextColor;
    
    //添加状态
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.equalTo(@30);
        make.height.equalTo(@16);
    }];
}
#pragma mark  懒加载
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.text = @"付费";
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.backgroundColor = [UIColor colorWithHex:@"#ff4a5b"];
        _statusLabel.font = kFont(10);
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.radius = 2;
    }
    return _statusLabel;
}
@end
