//
//  SchoolVideoTableViewCell.h
//  NewCaxjh
//
//  Created by Apple on 2018/9/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
static NSString* const SchoolVideoTableViewCellName = @"SchoolVideoTableViewCell";

@interface SchoolVideoTableViewCell : BaseTableViewCell
@property (nonatomic ,strong)UILabel *statusLabel;
@property (nonatomic ,strong)UILabel *statusPointLabel;
@property (nonatomic ,strong)UIView *selectFlagView;

@end
