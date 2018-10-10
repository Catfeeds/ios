//
//  AppDelegate.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import "GuidePagesViewController.h"
#import <IQKeyboardManager.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //记载视图
    BOOL isFirstLogin = [[NSUserDefaults standardUserDefaults]boolForKey:@"isFirstLogin"];
    if (!isFirstLogin) {
        //首次登录
        self.window.rootViewController = [[GuidePagesViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLogin"];
    }else{
        self.window.rootViewController = [self mainTabBarController];
    }
    
    //IQKeyboardManager
    // 控制整个功能是否启用
    [IQKeyboardManager sharedManager].enable = YES;// 控制整个功能是否启用
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;// 控制点击背景是否收起键盘
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;// 控制键盘上的工具条文字颜色是否用户自定义
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    //退出监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldLogout) name:DropOutSuccessNotificationName object:nil];
    
    return YES;
}
- (void)shouldLogout {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"USER_TOKEN"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"UserID"];
    self.window.rootViewController.tabBarController.selectedIndex = 0;
}

//主页
- (BaseTabBarViewController *)mainTabBarController {
    BaseTabBarViewController *tabBarController = [[BaseTabBarViewController alloc] init];
    return tabBarController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
