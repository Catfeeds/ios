//
//  BaseViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = NO;
    //电池栏
    //self.navigationController.navigationBar.barTintColor = backgroudColor;
    
    // 手势有效设置为YES  无效为NO
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //侧滑手势
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    if (self.navigationController.viewControllers.count > 1) {
        //设置返回按钮
        [self setupBackBarButtonItem];
    }else{
        //头像按钮
        [self setupLeftAvatarButtonItem];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    if (self.navigationController.viewControllers.count > 1) {
        
    }
}


- (BOOL)shouldAutorotate
{    // 不允许进行旋转
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{    // 返回默认情况
    return UIInterfaceOrientationMaskPortrait ;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{    // 返回默认情况
    return UIInterfaceOrientationPortrait;
}
//头像按钮
-(void)setupLeftAvatarButtonItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 31, 31);
    [button setImage:[UIImage imageNamed:@"header_default"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"header_default"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(avatarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
-(void)avatarButtonClick{
    
}
//返回按钮
-(void)setupBackBarButtonItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [button addTarget:self action:@selector(popButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
-(void)popButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

//自定义导航栏右侧按钮
-(void)setUpRightBarButtonItemWithTitle:(NSString *)title{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    CGSize size = [title sizeWithAttributes:@{@"NSFontAttributeName":[UIFont systemFontOfSize:14]}];
    rightBtn.frame = CGRectMake(0, 0, size.width, 30);
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didtouchRightBarItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.rightBarItem = rightBtn;
}
-(void)didtouchRightBarItem:(UIButton *)sender{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
