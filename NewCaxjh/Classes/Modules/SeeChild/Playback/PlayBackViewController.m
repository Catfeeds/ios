//
//  PlayBackViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "PlayBackViewController.h"
#import "PlayBackTableViewCell.h"
#import "TimeSelectViewController.h"

@interface PlayBackViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UIView *topView;
@property (nonatomic ,strong)UILabel *classRoomLabel;
@property (nonatomic ,strong)UIButton *selectTimeBtn;
@property (nonatomic ,strong)UIImageView *dividingLine;
@property (nonatomic ,strong)UITableView *tableView;

@end

@implementation PlayBackViewController
#pragma mark--生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重温课堂";
    
    [self setupUI];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@35);
    }];
    
    [self.classRoomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(15);
        make.centerY.equalTo(self.topView);
    }];
    
    [self.selectTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(0);
        make.centerY.equalTo(self.topView);
        make.width.equalTo(@75);
    }];
    
    [self.dividingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.selectTimeBtn.mas_left).offset(0);
        make.centerY.equalTo(self.topView);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
    }];
}
#pragma mark---点击事件
-(void)didTouchSelectTime{
    TimeSelectViewController *vc = [[TimeSelectViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark---UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlayBackCellName];
    if (!cell) {
        cell = [[PlayBackTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PlayBackCellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"2019-09-10 09:30 - 2019-09-10 10:00";
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = KLineColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#eeeeee"];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark--- setui
-(void)setupUI{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.classRoomLabel];
    [self.topView addSubview:self.selectTimeBtn];
    [self.topView addSubview:self.dividingLine];
    [self.view addSubview:self.tableView];
}

#pragma 懒加载
-(UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
-(UILabel *)classRoomLabel{
    if (!_classRoomLabel) {
        _classRoomLabel = [UILabel new];
        _classRoomLabel.textColor = defaultTextColor;
        _classRoomLabel.font = kFont(15);
        _classRoomLabel.text = @"北京新东方幼儿园-小班2班 教室";
    }
    return _classRoomLabel;
}
-(UIButton *)selectTimeBtn{
    if (!_selectTimeBtn) {
        _selectTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"see_filter"];
        [_selectTimeBtn setImage:image forState:UIControlStateNormal];
        [_selectTimeBtn setTitle:@" 筛选 " forState:UIControlStateNormal];
        _selectTimeBtn.titleLabel.font = kFont(15);
        CGSize titleSize = [@" 筛选 " sizeWithFont:kFont(15)];
        [_selectTimeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -titleSize.width, 0, 0)];
        [_selectTimeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width, 0, 0)];
        
        [_selectTimeBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
        
        [_selectTimeBtn addTarget:self action:@selector(didTouchSelectTime) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectTimeBtn;
}
-(UIImageView *)dividingLine{
    if (!_dividingLine) {
        _dividingLine = [UIImageView new];
        _dividingLine.image = [UIImage imageNamed:@"vertical_line"];
    }
    return _dividingLine;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces = NO;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
        [_tableView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
    }
    return _tableView;
}
@end
