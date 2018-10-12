//
//  FindChildIndexViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "FindChildIndexViewController.h"

@interface FindChildIndexViewController ()

@end

@implementation FindChildIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view showEmptyPlaceImage:@"no_data_prompt" WithContent:@"暂无数据"];
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
