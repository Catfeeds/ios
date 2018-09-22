//
//  BaseViewController.h
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic ,strong)UIButton *rightBarItem;
//自定义导航栏右侧按钮
-(void)setUpRightBarButtonItemWithTitle:(NSString *)title;
-(void)didtouchRightBarItem:(UIButton *)sender;
@end
