//
//  TimeSelectViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "TimeSelectViewController.h"
#import "WXDatePickerView.h"

@interface TimeSelectViewController ()<UITableViewDelegate,UITableViewDataSource,WXDatePickerViewDelegate>
@property (nonatomic ,strong)UIView *topView;
@property (nonatomic ,strong)UILabel *classRoomLabel;
@property (nonatomic ,strong)UITableView *tableView;
@property (strong, nonatomic) WXDatePickerView *dateView;
@property (nonatomic ,strong)NSIndexPath *selectIndexPath;
@property (nonatomic ,copy)NSString *beginTime;
@property (nonatomic ,copy)NSString *endTime;
@property (nonatomic ,strong)UIButton *submitBtn;
@end

@implementation TimeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"筛选";
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
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
    }];
}
#pragma mark---点击事件
-(void)didTouchSubmitBtn{
    NSLog(@"----点击提交");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    [UIView animateWithDuration:0.2 animations:^{
        self.dateView.transform = CGAffineTransformIdentity;
    }];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectIndexPath];
    if (self.selectIndexPath.row == 0) {
        self.beginTime = timer;
        cell.textLabel.text = [NSString stringWithFormat: @"开始时间 : %@",timer];
    }else{
        self.endTime = timer;
        cell.textLabel.text = [NSString stringWithFormat: @"结束时间 : %@",timer];
    }
    
    if (self.endTime.length > 0 && self.endTime.length > 0) {
        int compare = [self compareDate:self.beginTime withDate:self.endTime];
        if (compare == 1) {
            [self.submitBtn setBackgroundColor:selectedTexColor];
            self.submitBtn.enabled = YES;
        }else{
            NSLog(@"结束时间必须大于开始时间");
        }
    }
   
    
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    [UIView animateWithDuration:0.2 animations:^{
        self.dateView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark---UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeSelectCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TimeSelectCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"see_video"];
    cell.textLabel.textColor = defaultTextColor;
    cell.textLabel.font = kFont(13);
    if (indexPath.row == 0) {
        cell.textLabel.text = @"选择开始时间";
    }else{
        cell.textLabel.text = @"选择结束时间";
    }
    
    
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
    view.backgroundColor = [UIColor whiteColor];
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = kFont(15);
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = KLineColor;
    [submitBtn addTarget:self action:@selector(didTouchSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.radius = 20;
    submitBtn.enabled = NO;
    [view addSubview:submitBtn];
    self.submitBtn = submitBtn;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view).offset(-30);
        make.left.equalTo(view).offset(40);
        make.right.equalTo(view).offset(-40);
        make.height.equalTo(@40);
    }];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.view.height-50*2-35;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.2 animations:^{
        self.dateView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight);
        [self.dateView show];
    }];
    self.selectIndexPath = indexPath;
}

#pragma mark---私有方法
- (int)compareDate:(NSString *)date01 withDate:(NSString *)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result) {
            //date02比date01大
        case NSOrderedAscending: ci=1;break;
            //date02比date01小
        case NSOrderedDescending: ci=-1;break;
            //date02=date01
        case NSOrderedSame: ci=0;break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1);break;
    }
    return ci;
}

#pragma mark--- setui
-(void)setupUI{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.classRoomLabel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.dateView];
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
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces = NO;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
    }
    return _tableView;
}
-(WXDatePickerView *)dateView{
    if (!_dateView) {
        if (kIPhoneX) {
           _dateView = [[WXDatePickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight-88)];
        }else{
            _dateView = [[WXDatePickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight-64)];
        }
        _dateView.delegate = self;
    }
    return _dateView;
}
@end
