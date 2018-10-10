//
//  WebViewController.m
//  NewCaxjh
//
//  Created by Apple on 2018/10/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic ,strong)WKWebView *webView;

@end

@implementation WebViewController
-(void)dealloc{
    NSLog(@"WebViewController-dealloc");
}

#pragma mark---生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [SVProgressHUD show];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
    self.webView = nil;
}
-(void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
}
#pragma mark----WKScriptMessageHandler代理
//依然是这个协议方法,获取注入方法名对象,获取js返回的状态值.
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"backClick"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    //else{
//        NSData *data = [message.body dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        // alert弹出框
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:dic[@"content"] message:nil preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:alertAction];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
}
#pragma mark---WKUIDelegate
// 对应js的Alert方法
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    [SVProgressHUD dismiss];
    NSLog(@"%s--%@",__FUNCTION__,message);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark---WKNavigationDelegate
//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    /**
     *typedef NS_ENUM(NSInteger, WKNavigationActionPolicy) {
     WKNavigationActionPolicyCancel, // 取消
     WKNavigationActionPolicyAllow,  // 继续
     }
     */
    decisionHandler(WKNavigationActionPolicyAllow);
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //页面跳转
    //NSString *urlString = [navigationResponse.response.URL absoluteString];
    //NSLog(@"----%@",urlString);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}
//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [SVProgressHUD dismiss];
    [self.view makeToast:@"对不起,页面加载失败,请守候重试!"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----懒加载
-(WKWebView *)webView{
    if (!_webView) {
        // WKWebView的配置
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences = [[WKPreferences alloc] init];
        config.preferences.minimumFontSize = 10;
        config.preferences.javaScriptEnabled = YES;
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        config.userContentController = [[WKUserContentController alloc] init];
        config.processPool = [[WKProcessPool alloc] init];
        
        // 创建cookie 传递token跟member_id
        NSString *cookieString =  [NSString stringWithFormat:@"document.cookie = 'fromapp=ios';document.cookie = 'channel=appstore';document.cookie = 'token=%@';document.cookie = 'member_id=%@'",UserToken,UserID];
        WKUserContentController* userContentController = WKUserContentController.new;
        WKUserScript * cookieScript = [[WKUserScript alloc]
                                       initWithSource: cookieString
                                       injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [userContentController addUserScript:cookieScript];
        config.userContentController = userContentController;
        
        // 显示WKWebView
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, Height_StatusBar, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height-Height_StatusBar) configuration:config];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
        //添加注入js方法, oc与js端对应实现
        [config.userContentController addScriptMessageHandler:self name:@"backClick"];
        [config.userContentController addScriptMessageHandler:self name:@"submitClick"];
    }
    return _webView;
}

@end
