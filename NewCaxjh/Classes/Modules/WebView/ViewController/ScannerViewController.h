//
//  ScannerViewController.h
//  daibaowang
//
//  Created by 王霞 on 17/5/4.
//  Copyright © 2017年 wangxia. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^QRCodeBlock)(NSString *content);
@interface ScannerViewController : UIViewController
@property (nonatomic ,copy)QRCodeBlock qrCodeBlock;

-(void)setQrCodeBlock:(QRCodeBlock)qrCodeBlock;
@end
