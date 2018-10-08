//
//  BaseViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"
#import "UserIndexViewController.h"

@interface BaseViewController ()
@property (nonatomic ,strong)UIView *userIndexView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = NO;
    // 手势有效设置为YES  无效为NO
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //侧滑手势
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //不通明
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
    //电池栏
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHex:@"#242424"],
                                                NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:18]}];
    
    if (self.avatarBarItem) {
        if (UserToken == nil || [UserToken isEqualToString:@""]) {
            [self.avatarBarItem setImage:[UIImage imageNamed:@"header_default"] forState:UIControlStateNormal];
            [self.avatarBarItem setImage:[UIImage imageNamed:@"header_default"] forState:UIControlStateHighlighted];
        }else{
            UIImage *image  =[UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString:USERHeaderImage]]];
            CGSize asize = self.avatarBarItem.size;
            UIGraphicsBeginImageContext(asize);
            [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
            UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
            [self.avatarBarItem setImage:newimage forState:UIControlStateNormal];
            UIGraphicsEndImageContext();
        }
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
    self.avatarBarItem = button;
    button.frame = CGRectMake(0, 0, 32, 32);
    if (UserToken == nil || [UserToken isEqualToString:@""]) {
        [button setImage:[UIImage imageNamed:@"header_default"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"header_default"] forState:UIControlStateHighlighted];
    }else{
        [button sd_setImageWithURL:[NSURL URLWithString:USERHeaderImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"header_default"] options:SDWebImageRefreshCached];
        [button sd_setImageWithURL:[NSURL URLWithString:USERHeaderImage] forState:UIControlStateHighlighted placeholderImage:[UIImage imageNamed:@"header_default"] options:SDWebImageRefreshCached];
    }
    button.radius = 16;
    [button addTarget:self action:@selector(avatarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
//头像点击
-(void)avatarButtonClick{
    UserIndexViewController *userIndex = [[UserIndexViewController alloc]init];
    userIndex.view.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:userIndex.view];
    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:userIndex];
    [[UIApplication sharedApplication].keyWindow resignKeyWindow ];
    self.userIndexView = userIndex.view;
    
    [UIView animateWithDuration:0.5 animations:^{
        userIndex.view.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
    } completion:^(BOOL finished) {
        userIndex.bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }];
}
//返回按钮
-(void)setupBackBarButtonItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.popBarItem = button;
    button.frame = CGRectMake(0, 0, 32, 32);
    button.radius = 16;
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
    //自定义导航栏右侧图片按钮
-(void)setUpRightBarButtonItemWithImageName:(NSString *)name{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rightBtn.frame = CGRectMake(0, 0, image.size.width+10, image.size.height);
    [rightBtn setImage:image forState:UIControlStateNormal];
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
