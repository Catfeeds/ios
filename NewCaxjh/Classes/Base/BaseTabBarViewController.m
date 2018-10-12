//
//  BaseTabBarViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "SeeChildIndexViewController.h"
#import "FindChildIndexViewController.h"
#import "TeachChildIndexViewController.h"
#import "TalkChildIndexViewController.h"
#import "DiscoveryIndexViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //看孩
    SeeChildIndexViewController *lookIndexViewController = [[SeeChildIndexViewController alloc] init];
    [self addChildStoryboardName:lookIndexViewController title:@"看孩" imageView:@"tab_seechild.png" selectImg:@"tab_seechild_highlight.png"];
    
    //找孩
    FindChildIndexViewController *findIndexViewController = [[FindChildIndexViewController alloc] init];
    [self addChildStoryboardName:findIndexViewController title:@"找孩" imageView:@"tab_find.png" selectImg:@"tab_find_highlight.png"];
    
    //教孩
    TeachChildIndexViewController *techChildVC = [[TeachChildIndexViewController alloc]init];
    [self addChildStoryboardName:techChildVC title:@"教孩" imageView:@"tab_teachchild.png" selectImg:@"tab_teachchild_highlight.png"];
    
    //话孩
    TalkChildIndexViewController *chatIndexViewController = [[TalkChildIndexViewController alloc] init];
    [self addChildStoryboardName:chatIndexViewController title:@"话孩" imageView:@"tab_saychild.png" selectImg:@"tab_saychild_highlight.png"];
    
    //发现
    DiscoveryIndexViewController *discoveryIndexViewController = [[DiscoveryIndexViewController alloc] init];
    [self addChildStoryboardName:discoveryIndexViewController title:@"发现" imageView:@"tab_discover.png" selectImg:@"tab_discover_highlight.png"];
}

- (void)addChildStoryboardName:(UIViewController *)baseViewController
                         title:(NSString *)title
                     imageView:(NSString *)imgName
                     selectImg:(NSString *)selectImgName
{
    baseViewController.title = title;
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:baseViewController];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHex:@"#242424"],
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:18]}];
    //去除导航栏下方的横线;
    [nav.navigationBar setShadowImage:[UIImage new]];

    //tabBar
    nav.tabBarItem.title = title;
    [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    if ([title isEqualToString:@"教孩"]) {
        UIEdgeInsets insets = UIEdgeInsetsMake(-2, 0, 2, 0);
        nav.tabBarItem.imageInsets = insets;
    }
    nav.tabBarItem.image = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:selectedTexColor forKey:NSForegroundColorAttributeName];
    [nav.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
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
