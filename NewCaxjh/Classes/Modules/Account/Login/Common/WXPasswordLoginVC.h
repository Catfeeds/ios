//
//  WXPasswordLoginVC.h
//  caxjh
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018年 Yingchao Zou. All rights reserved.
//

#import "BaseViewController.h"

@protocol WXPasswordLoginViewControllerDelegate <NSObject>

- (void)toTab;

@end

@interface WXPasswordLoginVC : BaseViewController

@property (nonatomic, readwrite, strong) id<WXPasswordLoginViewControllerDelegate> delegate;

@end
