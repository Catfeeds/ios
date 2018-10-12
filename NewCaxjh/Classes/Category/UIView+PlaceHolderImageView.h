//
//  UIView+PlaceHolderImageView.h
//  Test
//
//  Created by Apple on 2018/9/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PlaceHolderImageView)

-(void)showEmptyPlaceImage:(NSString *)imageName;
-(void)showEmptyPlaceImage:(NSString *)imageName WithContent:(NSString *)title;
-(void) hidePlaceHolderImageView;
@end
