//
//  SchoolVideoTableViewCell.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SchoolVideoTableViewCell.h"


@implementation SchoolVideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark---setUI
-(void)setupUI{
    //基本属性
    self.textLabel.font = kFont(14);
    self.detailTextLabel.font = kFont(10);
    self.detailTextLabel.textColor = grayTexColor;
    
    //添加状态
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    //添加状态点
    [self.contentView addSubview:self.statusPointLabel];
    [self.statusPointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.statusLabel.mas_left).offset(-6);
        make.centerY.mas_equalTo(self.statusLabel);
        make.width.height.equalTo(@6);
    }];
    //添加左侧选中标志view
    [self.contentView addSubview:self.selectFlagView];
    [self.selectFlagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@3);
        make.left.equalTo(@0);
        make.height.equalTo(self.contentView.mas_height);
    }];
}
#pragma mark  懒加载
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.textColor = defaultTextColor;
        _statusLabel.backgroundColor = [UIColor whiteColor];
        _statusLabel.font = kFont(10);
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}
-(UILabel *)statusPointLabel{
    if (!_statusPointLabel) {
        _statusPointLabel = [UILabel new];
        _statusPointLabel.backgroundColor = selectedTexColor;
        _statusPointLabel.layer.cornerRadius = 3;
        _statusPointLabel.layer.masksToBounds = YES;
    }
    return _statusPointLabel;
}

- (UIView *)selectFlagView{
    if (!_selectFlagView) {
        _selectFlagView =[UIView new];
        _selectFlagView.backgroundColor = [UIColor clearColor];
    }
    return _selectFlagView;
}



@end
