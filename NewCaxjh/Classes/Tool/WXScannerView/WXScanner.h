//
//  WXScanner.h
//  daibaowang
//
//  Created by 王霞 on 17/5/3.
//  Copyright © 2017年 wangxia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ResultBlock)(NSString * result);
/**
 *  扫描二维码的封装，必须设置view 和 customContainerView属性,以及调用setResultBlock：方法执行后续操作
 */
@interface WXScanner : NSObject

/**
 *  扫描区域的父view
 */
@property (nonatomic ,strong) UIView * view;

/**
 *  扫描区域
 */
@property (nonatomic ,strong) UIView * customContainerView;

/**
 * 扫描器所在的viewController,扫描相册总的二维码一定设置
 */
@property (nonatomic ,weak) UIViewController * scannerController;

@property (nonatomic ,copy) ResultBlock resultBlock;

/**
 *  初始化方法
 */
- (instancetype)initWithDealResult:(ResultBlock)resultBlock;

- (instancetype)initWithView:(UIView *)view
         CustomContainerView:(UIView *)customContainerView
                  DealResult:(ResultBlock)resultBlock;
/**
 * 设置对扫描结果的处理
 */
- (void)setResultBlock:(ResultBlock)resultBlock;
/**
 * 相册选择二维码扫描,调用这个方法必须设置scannerController
 */
- (void)openCameralClick;

//开始扫描
- (void)startScan;

//扫描结束扫描
- (void)stopScan;

@end
