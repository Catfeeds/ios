//
//  UserSettingViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "UserSettingViewController.h"

@interface UserSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray *titlesArr;
@property (nonatomic, readwrite, strong) UIButton *signOutButton;
@end

@implementation UserSettingViewController
#pragma mark---生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.titlesArr = [NSArray arrayWithObjects:@"修改密码",@"安全密码",@"反馈意见",@"检查更新",@"关于我们",@"服务协议", nil];
    
    [self.view addSubview:self.tableView];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}
#pragma mark---点击事件
-(void)didTouchSignOutButton{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"USER_TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
    //发送退出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:DropOutSuccessNotificationName object:nil];
}

#pragma mark---UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserIndexCellName"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UserIndexCellName"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titlesArr[indexPath.row];
    cell.textLabel.font = kFont(15);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.signOutButton];
    [self.signOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.left.equalTo(view).offset(15);
        make.right.equalTo(view).offset(-15);
        make.height.equalTo(@40);
    }];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.view.height - 64- self.titlesArr.count * 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces = NO;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor whiteColor]];
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
    }
    return _tableView;
}
- (UIButton *)signOutButton {
    if (!_signOutButton) {
        _signOutButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _signOutButton.showsTouchWhenHighlighted = NO;
        [_signOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        _signOutButton.titleLabel.font = kFont(16);
        [_signOutButton setTitleColor:defaultTextColor forState:UIControlStateNormal];
        [_signOutButton setTitleColor:defaultTextColor forState:UIControlStateHighlighted];
        [_signOutButton setBackgroundColor:KLineColor];
        _signOutButton.layer.cornerRadius = 2;
        _signOutButton.layer.masksToBounds = YES;
        [_signOutButton addTarget:self action:@selector(didTouchSignOutButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signOutButton;
}
@end
