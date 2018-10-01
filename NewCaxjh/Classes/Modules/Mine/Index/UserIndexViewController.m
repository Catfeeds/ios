//
//  UserIndexViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "UserIndexViewController.h"
#import "UserSettingViewController.h"
#import "UserWalletViewController.h"
#import "RealNameViewController.h"

@interface UserIndexViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UIView *tableViewHeader;
@property (nonatomic ,strong)UIImageView *tableViewHeaderBg;
@property (nonatomic ,strong)UIButton *avatarButton;
@property (nonatomic ,strong)UILabel *phoneLabel;
@property (nonatomic ,strong)UIButton *accountAddBtn;
@property (nonatomic ,strong)UIButton *loginBtn;

//底部
@property (nonatomic ,strong)UIView *bottomView;
@property (nonatomic ,strong)UIButton *settingBtn;
@property (nonatomic ,strong)UIButton *schoolCenterBtn;

@property (nonatomic ,strong)NSArray *titlesArr;

@end

@implementation UserIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    self.view.backgroundColor = [UIColor clearColor];
    self.titlesArr = [NSArray arrayWithObjects:@{@"name":@"我的订单",@"imgUrl":@"user_order"},@{@"name":@"实名认证",@"imgUrl":@"user_realname"},@{@"name":@"绑定学生",@"imgUrl":@"user_binding"},@{@"name":@"找孩管理",@"imgUrl":@"user_manager"},@{@"name":@"教师认证",@"imgUrl":@"user_teacher"},@{@"name":@"上传课件",@"imgUrl":@"user_courseware"},@{@"name":@"我的钱包",@"imgUrl":@"user_wallet"},@{@"name":@"我的收藏",@"imgUrl":@"user_collection"},@{@"name":@"教育商城",@"imgUrl":@"user_education"},@{@"name":@"客服",@"imgUrl":@"user_customer"}, nil];
    self.navigationController.navigationBar.hidden = YES;
    
    //添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTouchBgView)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self.bgView addGestureRecognizer:tap];
    
    if (UserToken == nil || [UserToken isEqualToString:@""]) {
        self.tableViewHeaderBg.image = [UIImage imageNamed:@"user_noLogin_bg"];
        self.loginBtn.hidden = NO;
        self.phoneLabel.hidden = YES;
        self.accountAddBtn.hidden = YES;
    }else{
        self.tableViewHeaderBg.image = [UIImage imageNamed:@"user_login_bg"];
        self.loginBtn.hidden = YES;
        self.phoneLabel.hidden = NO;
        self.accountAddBtn.hidden = NO;
        self.phoneLabel.text = UserPhone;
        self.phoneLabel.text = [self.phoneLabel.text stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }

}
//布局
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    /********底部************/
    if (kIPhoneX) {
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(self.view);
            make.height.equalTo(@84);
            make.width.equalTo(self.view.mas_width).multipliedBy(0.7);
            make.bottom.equalTo(self.view).offset(0);
        }];
    }else{
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(self.view);
            make.height.equalTo(@60);
            make.width.equalTo(self.view.mas_width).multipliedBy(0.7);
        }];
    }
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(30);
        make.top.equalTo(self.bottomView).offset(10);
    }];
    [self.schoolCenterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.settingBtn.mas_right).offset(60);
        make.top.equalTo(self.bottomView).offset(10);
    }];
    [self initButton:self.settingBtn];
    [self initButton:self.schoolCenterBtn];
    /********tableView************/
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.width.equalTo(self.bottomView.mas_width);
    }];
    if (kIPhoneX) {
        [self.tableViewHeaderBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.tableViewHeader);
            make.height.equalTo(@150);
        }];
    }else{
        [self.tableViewHeaderBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.tableViewHeader);
            make.height.equalTo(@120);
        }];
    }
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self.tableViewHeaderBg);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableViewHeaderBg.mas_bottom).offset(5);
        make.centerX.equalTo(self.tableViewHeader);
    }];
    [self.accountAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLabel.mas_bottom);
        make.centerX.equalTo(self.tableViewHeader);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableViewHeaderBg.mas_bottom).offset(2);
        make.centerX.equalTo(self.tableViewHeader);
    }];
}
#pragma mark---点击
-(void)didTouchAvatarButton{
    
}
//点击背景
-(void)didTouchBgView{
    self.bgView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}
-(void)didTouchSchoolCenterBtn{
    
}
-(void)didTouchSettingBtn{
    UserSettingViewController *vc = [[UserSettingViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    //取出根视图控制器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //取出当前选中的导航控制器
    UINavigationController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:vc animated:YES];
    
    //销毁页面
    [self.view removeFromSuperview];
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
    cell.textLabel.text = self.titlesArr[indexPath.row][@"name"];
    cell.textLabel.font = kFont(15);
    UIImage *image = [UIImage imageNamed:self.titlesArr[indexPath.row][@"imgUrl"]];
    cell.imageView.image = image;
    CGSize itemSize = CGSizeMake(image.size.width+30, image.size.height);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(30, 0, image.size.width, image.size.height);
    [image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = self.titlesArr[indexPath.row][@"name"];
    //取出根视图控制器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //取出当前选中的导航控制器
    UINavigationController *nav = [tabBarVc selectedViewController];
    if ([name isEqualToString:@"我的钱包"]) {
        UserWalletViewController *vc = [[UserWalletViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
        //销毁页面
        [self.view removeFromSuperview];
    }else if ([name isEqualToString:@"实名认证"]) {
        RealNameViewController *vc = [[RealNameViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
        //销毁页面
        [self.view removeFromSuperview];
    }
}

#pragma mark--- setui
-(void)setupUI{
    //背景图
    [self.view addSubview:self.bgView];
    //底部视图
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.settingBtn];
    [self.bottomView addSubview:self.schoolCenterBtn];
    //tableView
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableViewHeader;
    [self.tableViewHeader addSubview:self.tableViewHeaderBg];
    [self.tableViewHeader addSubview:self.avatarButton];
    [self.tableViewHeader addSubview:self.phoneLabel];
    [self.tableViewHeader addSubview:self.accountAddBtn];
    [self.tableViewHeader addSubview:self.loginBtn];

}

#pragma 懒加载
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        //_bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _bgView.backgroundColor  = [UIColor clearColor];
    }
    return _bgView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces = NO;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor whiteColor]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
    }
    return _tableView;
}
-(UIView *)tableViewHeader{
    if (!_tableViewHeader) {
        if (kIPhoneX) {
            _tableViewHeader = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.width, 200)];
        }else{
            _tableViewHeader = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.width, 170)];
        }
        _tableViewHeader.backgroundColor = [UIColor whiteColor];
    }
    return _tableViewHeader;
}
-(UIImageView *)tableViewHeaderBg{
    if (!_tableViewHeaderBg) {
        _tableViewHeaderBg = [[UIImageView alloc]init];
        _tableViewHeaderBg.image = [UIImage imageNamed:@"user_noLogin_bg"];
    }
    return _tableViewHeaderBg;
}
-(UIButton *)avatarButton{
    if (!_avatarButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"tab_user"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tab_user"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(didTouchAvatarButton) forControlEvents:UIControlEventTouchUpInside];
        _avatarButton = button;
    }
    return _avatarButton;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel new];
        _phoneLabel.font = kFont(14);
        _phoneLabel.textColor = defaultTextColor;
        _phoneLabel.text = @"159****5427";
    }
    return _phoneLabel;
}
-(UIButton *)accountAddBtn{
    if (!_accountAddBtn) {
        _accountAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _accountAddBtn.titleLabel.font = kFont(10);
        [_accountAddBtn setTitle:@" *个副账号" forState:UIControlStateNormal];
        [_accountAddBtn setTitleColor:selectedTexColor forState:UIControlStateNormal];
    }
    return _accountAddBtn;
    
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.titleLabel.font = kFont(16);
        [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
    }
    return _loginBtn;
}
-(UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.titleLabel.font = kFont(11);
        [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_settingBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
        [_settingBtn setImage:[UIImage imageNamed:@"user_setting"] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(didTouchSettingBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}
-(UIButton *)schoolCenterBtn{
    if (!_schoolCenterBtn) {
        _schoolCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _schoolCenterBtn.titleLabel.font = kFont(11);
        [_schoolCenterBtn setTitle:@"学校中心" forState:UIControlStateNormal];
        [_schoolCenterBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
        [_schoolCenterBtn setImage:[UIImage imageNamed:@"user_school"] forState:UIControlStateNormal];
        [_schoolCenterBtn addTarget:self action:@selector(didTouchSchoolCenterBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _schoolCenterBtn;
}
//将按钮设置为图片在上，文字在下
-(void)initButton:(UIButton*)btn{
    float  spacing = 8;//图片和文字的上下间距
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    btn.clipsToBounds = NO;
    btn.layer.masksToBounds = NO;
    [btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(totalHeight));
    }];
    btn.layer.masksToBounds = NO;
}
@end
