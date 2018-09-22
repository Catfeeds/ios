//
//  BaseTableViewCell.m
//  NewCaxjh
//
//  Created by Apple on 2018/9/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

-(void)setUnSelectAction:(UnSelectAction)unSelectAction{
    _unSelectAction = unSelectAction;
}
-(void)setSelectAction:(SelectAction)selectAction{
    _selectAction = selectAction;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    if (selected == 0) {
        NSLog(@"取消选中");
        if (_unSelectAction) {
            _unSelectAction();
        }
    }else{
        if (self.checkReSelected) {
            if (self.selected == 1 ){
                NSLog(@"重复选中");
                return;
            }
        }
        if (_selectAction) {
            _selectAction();
        }
    }
    [super setSelected:selected animated:animated];
}


@end
