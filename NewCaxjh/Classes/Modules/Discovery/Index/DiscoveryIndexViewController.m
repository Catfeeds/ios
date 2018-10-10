//
//  DiscoveryIndexViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "DiscoveryIndexViewController.h"
#import "DiscoveryIcon.h"

@interface DiscoveryIndexViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataList;
@property (nonatomic ,strong)UILabel *promptNumLabel;
@end

@implementation DiscoveryIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发现";
    self.view.backgroundColor = KbackgoundColor;
    //右侧导航栏
    [self setUpRightBarButtonItemWithImageName:@"discovery_message"];
    self.rightBarItem.frame = CGRectMake(0, 0, self.rightBarItem.imageView.image.size.width+20, self.rightBarItem.size.height);
    //UI
    [self setupUI];
    //数据
    [self requestDiscoveryListData];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
}

#pragma mark---数据
-(void)requestDiscoveryListData{
    [SVProgressHUD show];
    NSDictionary *parmas = @{@"type":@"2"};
    [WXAFNetworkCore postHttpRequestWithURL:kAPIDiscoveryListURL params:parmas succeedBlock:^(id responseObj) {
        [SVProgressHUD dismiss];
        ResponseModel *response = [ResponseModel mj_objectWithKeyValues:responseObj];
        if ([response.code isEqualToString:@"200"]) {
            NSArray *result = response.result;
            for (NSDictionary *dic in result) {
                DiscoveryIcon *model = [DiscoveryIcon mj_objectWithKeyValues:dic];
                [self.dataList addObject:model];
            }
             [self.tableView reloadData];
        } else {
            [self.view makeToast:response.message duration:1.0 position:CSToastPositionTop];
        }
    } failBlock:^(id error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
    }];
}

#pragma mark---UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DiscoveryIcon *model = self.dataList[section];
    NSArray *array = model.subTab;
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserIndexCellName"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UserIndexCellName"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    DiscoveryIcon *model = self.dataList[indexPath.section];
    NSArray *array = model.subTab;
    IconModel *iconModel = array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = iconModel.icon_name;
    cell.textLabel.font = kFont(15);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:iconModel.icon_3] placeholderImage:[UIImage imageNamed:@"discovery_shop"]];
    cell.layoutMargins = UIEdgeInsetsMake(0, 20, 0, 0);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = KbackgoundColor;
    DiscoveryIcon *model = self.dataList[section];
    NSString *title = model.tab;
    if (title.length > 0) {
        //头视图
        UIView *headView = [UIView new];
        headView.backgroundColor = [UIColor whiteColor];
        [view addSubview:headView];
        [headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(view);
            make.top.equalTo(view).offset(15);
        }];
        //标题
        UILabel *lable = [UILabel new];
        lable.backgroundColor = [UIColor whiteColor];
        lable.textColor = defaultTextColor;
        lable.font = kFont(15);
        lable.text = title;
        [view addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView).offset(20);
            make.bottom.equalTo(headView).offset(-5);
        }];
        //线
        UIView *lineView = [UIView new];
        lineView.backgroundColor = selectedTexColor;
        [headView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView).offset(20);
            make.centerY.equalTo(lable);
            make.width.equalTo(@3);
            make.height.equalTo(@16);
        }];
    }
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    DiscoveryIcon *model = self.dataList[section];
    NSString *title = model.tab;
    if (title.length > 0) {
        return 50;
    }else{
        return 15;
    }
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
    
}

#pragma mark--UI
-(void)setupUI{
    [self.view addSubview:self.tableView];
    [self.rightBarItem addSubview:self.promptNumLabel];
}

#pragma 懒加载
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc]init];
    }
    return _dataList;
}
//ui
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = KbackgoundColor;
        _tableView.bounces = NO;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor whiteColor]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
    }
    return _tableView;
}
-(UILabel *)promptNumLabel{
    if (!_promptNumLabel) {
        _promptNumLabel = [UILabel new];
        _promptNumLabel.backgroundColor = [UIColor colorWithHex:@"#ff5b5b"];
        _promptNumLabel.textColor = [UIColor whiteColor];
        _promptNumLabel.text = @"13";
        _promptNumLabel.font = kFont(7);
        _promptNumLabel.textAlignment = NSTextAlignmentCenter;
        CGSize size = [@"3" sizeWithFont:kFont(7)];
        if (size.width > size.height) {
            _promptNumLabel.frame = CGRectMake(self.rightBarItem.right-13, self.rightBarItem.top, size.width, size.width);
            _promptNumLabel.radius = size.width/2;
        }else{
             _promptNumLabel.frame = CGRectMake(self.rightBarItem.right-13, self.rightBarItem.top, size.height, size.height);
            _promptNumLabel.radius = size.height/2;
        }
    }
    return _promptNumLabel;
}

@end
