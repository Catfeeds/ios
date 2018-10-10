//
//  IconModel.h
//  NewCaxjh
//
//  Created by Apple on 2018/10/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconModel : NSObject
@property (nonatomic, readwrite, copy) NSString *group_name;
@property (nonatomic, readwrite, copy) NSString *group_type;
@property (nonatomic, readwrite, copy) NSString *icon_1;
@property (nonatomic, readwrite, copy) NSString *icon_2;
@property (nonatomic, readwrite, copy) NSString *icon_3;
@property (nonatomic, readwrite, copy) NSString *icon_name;
@property (nonatomic, readwrite, copy) NSString *icon_sign;
@property (nonatomic, readwrite, copy) NSString *icon_type;
@property (nonatomic, readwrite, copy) NSString *link;

@property (nonatomic, readwrite, strong) NSNumber *link_type;
@end
