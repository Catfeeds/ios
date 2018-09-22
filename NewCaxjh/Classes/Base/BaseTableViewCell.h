//
//  BaseTableViewCell.h
//  NewCaxjh
//
//  Created by Apple on 2018/9/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectAction)(void);
typedef void(^UnSelectAction)(void);

@interface BaseTableViewCell : UITableViewCell

@property(nonatomic ,copy)SelectAction selectAction;
@property(nonatomic ,copy)UnSelectAction unSelectAction;
@property(nonatomic ,assign) BOOL checkReSelected;

- (void)setSelectAction:(SelectAction)selectAction;
- (void)setUnSelectAction:(UnSelectAction)unSelectAction;

@end
