//
//  TalkChildIndexViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "TalkChildIndexViewController.h"

@interface TalkChildIndexViewController ()

@end

@implementation TalkChildIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view showEmptyPlaceImage:@"no_friend_prompt" WithContent:@"暂无好友"];
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
