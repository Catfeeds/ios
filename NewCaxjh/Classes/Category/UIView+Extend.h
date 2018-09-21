//
//  UIView+Extend.h
//  NewCaxjh
//
//  Created by Apple on 2018/9/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;


@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat radius;



@property (nonatomic, assign) CGFloat   insideCenterX;
@property (nonatomic, assign) CGFloat   insideCenterY;
@property (nonatomic, assign) CGPoint   insideCenter;

/**
 *  添加边框
 */
-(void)setBorder:(UIColor *)color width:(CGFloat)width;
/**
 *  批量移除视图
 *
 *  @param views 需要移除的视图数组
 */
+(void)removeViews:(NSArray *)views;

@end
