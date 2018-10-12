//
//  WXScanner.m
//  daibaowang
//
//  Created by 王霞 on 17/5/3.
//  Copyright © 2017年 wangxia. All rights reserved.
//

#import "WXScanner.h"
#import <AVFoundation/AVFoundation.h>

@interface WXScanner ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic ,strong) AVCaptureDevice * device;
@property (nonatomic ,strong) AVCaptureSession * session;
@property (nonatomic ,strong) AVCaptureMetadataOutput * output;
@property (nonatomic ,strong) AVCaptureDeviceInput * input;
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer * previewLayer;
@property (nonatomic,strong) CALayer *containerLayer;
@end
@implementation WXScanner
#pragma mark -- 资源加载
//获取摄像设备
-(AVCaptureDevice *)device{
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
    }
    return _device;
}
//获取输入流
- (AVCaptureDeviceInput *)input{
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}
//初始化链接对象
- (AVCaptureSession *)session{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc]init];
        //高质量的采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    return _session;
}
- (AVCaptureVideoPreviewLayer *)previewLayer{
    if (_previewLayer == nil) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _previewLayer;
}
//创建输出流
- (AVCaptureMetadataOutput *)output{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        
        // 1.获取屏幕的frame
        CGRect viewRect = self.view.frame;
        // 2.获取扫描容器的frame
        CGRect containerRect = self.customContainerView.frame;
        
        CGFloat x = containerRect.origin.y / viewRect.size.height;
        CGFloat y = containerRect.origin.x / viewRect.size.width;
        CGFloat width = containerRect.size.height / viewRect.size.height;
        CGFloat height = containerRect.size.width / viewRect.size.width;
        
        // CGRect outRect = CGRectMake(x, y, width, height);
        // [_output rectForMetadataOutputRectOfInterest:outRect];
        _output.rectOfInterest = CGRectMake(x, y, width, height);
    }
    return _output;
    
}
- (CALayer *)containerLayer{
    if (_containerLayer == nil) {
        _containerLayer = [[CALayer alloc] init];
    }
    return _containerLayer;
}


#pragma mark ------- 摄像头扫描二维码 ------------
#pragma mark -- 初始化方法
- (instancetype)initWithDealResult:(ResultBlock)resultBlock{
    self = [super init];
    if (self) {
        [self setResultBlock:resultBlock];
    }
    return self;
}
- (instancetype)initWithView:(UIView *)view
         CustomContainerView:(UIView *)customContainerView
                  DealResult:(ResultBlock)resultBlock{
    self = [super init];
    if (self) {
        self.view = view;
        self.customContainerView = customContainerView;
        [self setResultBlock:resultBlock];
    }
    return self;
}
#pragma mark -- 设置返回扫描结果的block
- (void)setResultBlock:(ResultBlock)resultBlock{
    _resultBlock = resultBlock;
}

#pragma mark -- 扫描相关的方法
//开始扫描
- (void)startScan
{
    NSAssert(self.view, @"设置view属性");
    NSAssert(self.customContainerView, @"设置customContainerView属性");
    // 1.判断输入能否添加到会话中
    if (![self.session canAddInput:self.input]) return;
    [self.session addInput:self.input];
    
    // 2.判断输出能够添加到会话中
    if (![self.session canAddOutput:self.output]) return;
    [self.session addOutput:self.output];
    
    // 4.设置输出能够解析的数据类型
    // 注意点: 设置数据类型一定要在输出对象添加到会话之后才能设置
    //self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // 5.设置监听监听输出解析到的数据
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 6.添加预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    self.previewLayer.frame = self.view.bounds;
    
    // 7.添加容器图层
    [self.view.layer addSublayer:self.containerLayer];
    self.containerLayer.frame = self.view.bounds;
    
    // 8.开始扫描
    [self.session startRunning];
}
//扫描结束扫描
- (void)stopScan{
    [self.session stopRunning];
    self.session = nil;
}
//划线
- (void)drawLine:(AVMetadataMachineReadableCodeObject *)objc
{
    NSArray *array = objc.corners;
    
    // 1.创建形状图层, 用于保存绘制的矩形
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    // 设置线宽
    layer.lineWidth = 2;
    // 设置描边颜色
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    // 2.创建UIBezierPath, 绘制矩形
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint point = CGPointZero;
    int index = 0;
    
    CFDictionaryRef dict = (__bridge CFDictionaryRef)(array[index++]);
    // 把点转换为不可变字典
    // 把字典转换为点，存在point里，成功返回true 其他false
    CGPointMakeWithDictionaryRepresentation(dict, &point);
    
    // 设置起点
    [path moveToPoint:point];
    
    // 2.2连接其它线段
    for (int i = 1; i<array.count; i++) {
        CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)array[i], &point);
        [path addLineToPoint:point];
    }
    // 2.3关闭路径
    [path closePath];
    
    layer.path = path.CGPath;
    // 3.将用于保存矩形的图层添加到界面上
    [self.containerLayer addSublayer:layer];
}
//清除线
- (void)clearLayers
{
    if (self.containerLayer.sublayers)
    {
        for (CALayer *subLayer in self.containerLayer.sublayers)
        {
            [subLayer removeFromSuperlayer];
        }
    }
}

#pragma mark --------AVCaptureMetadataOutputObjectsDelegate ---------
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // id 类型不能点语法,所以要先去取出数组中对象
    AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
    
    if (object == nil) return;
    // 只要扫描到结果就会调用
    self.resultBlock(object.stringValue);
    
    // 清除之前的描边
    [self clearLayers];
    
    //返回主线程，并将扫描的结果传回主线程
    //[self performSelectorOnMainThread:@selector(stopScan) withObject:nil waitUntilDone:NO];
    
    // 对扫描到的二维码进行描边
    //AVMetadataMachineReadableCodeObject *obj = (AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:object];
    
    // 绘制描边
    // [self drawLine:obj];
}

#pragma mark ------- 相册扫描二维码 ------------

- (void)openCameralClick{
    NSAssert(self.scannerController, @"必须设置scannerController");
    // 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 设置代理
    ipc.delegate = self;
    
    // 5.modal出这个控制器
    [self.scannerController presentViewController:ipc animated:YES completion:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.scannerController viewWillDisappear:animated];
    [self.session stopRunning];
}
#pragma mark -------- UIImagePickerControllerDelegate---------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 1.取出选中的图片
    UIImage *pickImage = info[UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImagePNGRepresentation(pickImage);
    
    CIImage *ciImage = [CIImage imageWithData:imageData];
    
    // 2.从选中的图片中读取二维码数据
    // 2.1创建一个探测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    // 2.2利用探测器探测数据
    NSArray *feature = [detector featuresInImage:ciImage];
    if (feature.count >=1) {
        [picker dismissViewControllerAnimated:YES completion:^{
            // 2.3取出探测到的数据
            for (CIQRCodeFeature *result in feature) {
                self.resultBlock(result.messageString);
                //                NSString *urlStr = result.messageString;
                //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }
        }];
    }else{
        //图片中没有二维码
        [picker dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
            self.resultBlock(@"falus");
        }];
    }
}

@end
