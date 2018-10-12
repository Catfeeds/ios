//
//  UIView+PlaceHolderImageView.m
//  Test
//
//  Created by Apple on 2018/9/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "UIView+PlaceHolderImageView.h"

static NSInteger placeImageViewTag = 1000;
static NSInteger placeholderTextTag = 1001;

@implementation UIView (PlaceHolderImageView)

-(void)showEmptyPlaceImage:(NSString *)imageName
{
    UIImageView *placeImageView = [(UIImageView *)self viewWithTag:placeImageViewTag];
    if(placeImageView){
        placeImageView.image = [UIImage imageNamed:imageName];
        [self bringSubviewToFront:placeImageView];
        return;
    }
    placeImageView = [[UIImageView alloc]init];
    placeImageView.tag = placeImageViewTag;
    if (imageName != nil && imageName.length > 0) {
        placeImageView.image = [UIImage imageNamed:imageName];
    }else{
      placeImageView.image = [UIImage imageNamed:@"no_data_prompt"];
    }
    [self addSubview:placeImageView];
    [placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(-Height_TapBar-Height_NavBar);
    }];
    [self bringSubviewToFront:placeImageView];
}

-(void)showEmptyPlaceImage:(NSString *)imageName WithContent:(NSString *)title
{
    UIImageView *placeImageView = [(UIImageView *)self viewWithTag:placeImageViewTag];
    if(placeImageView){
        placeImageView.image = [UIImage imageNamed:imageName];
    }else{
        placeImageView = [[UIImageView alloc]init];
        placeImageView.tag = placeImageViewTag;
        placeImageView.center = self.center;
        if (imageName != nil && imageName.length > 0) {
            placeImageView.image = [UIImage imageNamed:imageName];
        }else{
            placeImageView.image = [UIImage imageNamed:@"no_data_prompt"];
        }
        [self addSubview:placeImageView];
        [placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_centerY).offset(-20);
        }];
    }
    UILabel *placeholderLabel = [(UILabel *)self viewWithTag:placeholderTextTag];
    if (placeholderLabel) {
        placeholderLabel.text = title;
    }else{
        placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.text = title;
        placeholderLabel.tag = placeholderTextTag;
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.font = [UIFont systemFontOfSize:13];
        placeholderLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:placeholderLabel];
        [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(placeImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self);
        }];
    }
    [self bringSubviewToFront:placeImageView];
    [self bringSubviewToFront:placeholderLabel];
}
-(void) hidePlaceHolderImageView{
    UIImageView *placeImageView = [(UIImageView *)self viewWithTag:placeImageViewTag];
    if (placeImageView) {
        [placeImageView removeFromSuperview];
    }
    UILabel *placeholderLabel = [(UILabel *)self viewWithTag:placeholderTextTag];
    if (placeholderLabel) {
        [placeholderLabel removeFromSuperview];
    }
}

@end
