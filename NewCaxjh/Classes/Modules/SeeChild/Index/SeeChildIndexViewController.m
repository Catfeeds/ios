//
//  SeeChildIndexViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SeeChildIndexViewController.h"
#import "SeeChildNoLoginInVC.h"
#import "SchoolVideoTableViewCell.h"

@interface SeeChildIndexViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UIView *topView;
@property (nonatomic ,strong)UIView *videoView;
@property (nonatomic ,strong)UILabel *schoolLabel;
@property (nonatomic ,strong)UIButton *schoolSelectBtn;
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation SeeChildIndexViewController
#pragma -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    [self setUpRightBarButtonItemWithTitle:@"回放"];
    self.view.backgroundColor = KbackgoundColor;
    SeeChildNoLoginInVC *onloginVC = [[SeeChildNoLoginInVC alloc]init];
    [self addChildViewController:onloginVC];
    //[self.view addSubview:onloginVC.view];
    
    [self setupUI];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.4);
    }];
    
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.topView.mas_height).offset(-40);
    }];
    
    [self.schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self.topView);
        make.height.equalTo(@40);
    }];
    
    [self.schoolSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView);
        make.height.equalTo(@40);
        make.right.equalTo(self.topView).offset(-20);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom).offset(15);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--- setui
-(void)setupUI{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.videoView];
    [self.topView addSubview:self.schoolLabel];
    [self.topView addSubview:self.schoolSelectBtn];
    [self.view addSubview:self.tableView];
}



#pragma mark---UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchoolVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SchoolVideoTableViewCellName];
    if (!cell) {
        cell = [[SchoolVideoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SchoolVideoTableViewCellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"教师区";
    cell.imageView.image = [UIImage imageNamed:@"see_camera_selected"];
    cell.detailTextLabel.text = @"飘满朗朗声";
    cell.statusLabel.text = @"在线";
    cell.checkReSelected = YES;
    __weak typeof(cell) weakCell = cell;
    [cell setSelectAction:^{
        NSLog(@"被选中");
        weakCell.selectFlagView.backgroundColor = selectedTexColor;
        weakCell.textLabel.textColor = selectedTexColor;
    }];
    
    [cell setUnSelectAction:^{
        NSLog(@"取消选中");
        if (indexPath.section == 4) {
            return ;
        }
        weakCell.selectFlagView.backgroundColor = [UIColor clearColor];
        weakCell.textLabel.textColor = defaultTextColor;
    }];
    if (indexPath.section == 4) {
        cell.userInteractionEnabled = NO;
        cell.statusLabel.text = @"离线";
        cell.statusLabel.textColor = grayTexColor;
        cell.statusPointLabel.backgroundColor = grayTexColor;
        cell.imageView.image = [UIImage imageNamed:@"see_camera"];
        cell.textLabel.textColor = KLineColor;
        cell.detailTextLabel.textColor = KLineColor;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = KbackgoundColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#eeeeee"];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
}





#pragma 懒加载
-(UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
-(UIView *)videoView{
    if (!_videoView) {
        _videoView = [UIView new];
        _videoView.backgroundColor = [UIColor colorWithHex:@"#393939"];
    }
    return _videoView;
}
-(UILabel *)schoolLabel{
    if (!_schoolLabel) {
        _schoolLabel = [UILabel new];
        _schoolLabel.textColor = defaultTextColor;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"北京市附属医院第三儿童幼儿园"];
        [string addAttribute:NSForegroundColorAttributeName value:grayTexColor range:NSMakeRange(0, string.length-7)];
        [string addAttribute:NSForegroundColorAttributeName value:selectedTexColor range:NSMakeRange(string.length-7, 7)];
        _schoolLabel.attributedText = string;
        _schoolLabel.font = kFont(12);
    }
    return _schoolLabel;
}
-(UIButton *)schoolSelectBtn{
    if (!_schoolSelectBtn) {
        _schoolSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_schoolSelectBtn setImage:[UIImage imageNamed:@"see_change"] forState:UIControlStateNormal];
    }
    return _schoolSelectBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
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
