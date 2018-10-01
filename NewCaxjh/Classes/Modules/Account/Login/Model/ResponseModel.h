//
//  ResponseModel.h
//  NewCaxjh
//
//  Created by Apple on 2018/9/29.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseModel : NSObject
@property (nonatomic, readwrite, copy) NSString *message;
@property (nonatomic, readwrite, strong) id result;
@property (nonatomic, readwrite, copy) NSString *code;
@end
