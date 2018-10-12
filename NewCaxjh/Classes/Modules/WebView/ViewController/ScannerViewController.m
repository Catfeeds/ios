//
//  ScannerViewController.m
//  daibaowang
//
//  Created by 王霞 on 17/5/4.
//  Copyright © 2017年 wangxia. All rights reserved.
//

#import "ScannerViewController.h"
#import "WXScanner.h"

@interface ScannerViewController ()
@property (nonatomic,copy)UIImageView * readLineView;
@property (strong ,nonatomic)UIView *scannerView;
@property (strong ,nonatomic)WXScanner *scanner;
@end

@implementation ScannerViewController
#pragma mark---生命周期
-(void)dealloc{
  
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = true;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)setQrCodeBlock:(QRCodeBlock)qrCodeBlock{
    _qrCodeBlock = qrCodeBlock;
}
#pragma mark---事件
-(void)popButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark---UI
-(void)setUI{
    //添加子视图
    [self setupBackBarButtonItem];
    [self.view addSubview:self.scannerView];
    [self.scannerView addSubview:self.readLineView];
    //循环扫描动画
    [self loopDrawLine];
    //扫表二维码
    __weak typeof(self) weakSelf = self;
    self.scanner = [[WXScanner alloc]initWithView:self.view CustomContainerView:self.scannerView DealResult:^(NSString *result) {
        if(self.qrCodeBlock){
            self.qrCodeBlock(result);
        }
        [weakSelf.scanner stopScan];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.scanner.scannerController = weakSelf;
    [self.scanner startScan];
}
-(void)loopDrawLine
{
    if(self.readLineView){
        self.readLineView.frame = CGRectMake(0,4, self.scannerView.bounds.size.width, 4);
    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:2 animations:^{
        //修改fream的代码写在这里
        weakSelf.readLineView.frame =CGRectMake(0, self.scannerView.bounds.size.height, self.scannerView.bounds.size.width, 4);
    } completion:^(BOOL finished) {
        [weakSelf loopDrawLine];
    }];
}

#pragma mark---懒加载
-(UIImageView *)readLineView{
    if(!_readLineView){
        CGRect rect = CGRectMake(0,4, self.scannerView.bounds.size.width, 4);
        _readLineView = [[UIImageView alloc] initWithFrame:rect];
        [_readLineView setImage:[UIImage imageNamed:@"scanLine"]];
        _readLineView.alpha = 1;
        _readLineView.frame = rect;
    }
    return _readLineView;
}
-(UIView *)scannerView{
    if (!_scannerView) {
        _scannerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 240)];
        _scannerView.center = self.view.center;
        UIImage *Image = [UIImage imageNamed:@"scanscanBg"];
        [_scannerView setBackgroundColor:[UIColor colorWithPatternImage:[self zoomImage:Image toScale:CGSizeMake(_scannerView.bounds.size.width, _scannerView.bounds.size.height)]]];
    }
    return _scannerView;
}
//返回按钮
-(void)setupBackBarButtonItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    button.radius = 16;
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [button addTarget:self action:@selector(popButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
//截取图片
- (UIImage *)zoomImage:(UIImage *)image toScale:(CGSize)reSize
{
    //绘制这个大小的图片
    UIGraphicsBeginImageContext(reSize);
    [image drawInRect:CGRectMake(0,0, reSize.width, reSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
