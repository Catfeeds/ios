//
//  WXDatePickerView.h
//  NewCaxjh
//
//  Created by Apple on 2018/9/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXDatePickerViewDelegate <NSObject>

/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer;

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate;

@end

@interface WXDatePickerView : UIView

@property (copy, nonatomic) NSString *title;
/// 是否自动滑动 默认YES
@property (assign, nonatomic) BOOL isSlide;

/// 选中的时间， 默认是当前时间 2017-02-12 13:35
@property (copy, nonatomic) NSString *date;

/// 分钟间隔 默认5分钟
@property (assign, nonatomic) NSInteger minuteInterval;

@property (weak, nonatomic) id <WXDatePickerViewDelegate> delegate;

/// 显示
- (void)show;
@end
