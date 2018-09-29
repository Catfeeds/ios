//
//  WXAFNetworkCore.m
//  NobuhiroCredit
//
//  Created by wangxia on 16/7/8.
//  Copyright © 2016年 wangxia. All rights reserved.
//

#import "WXAFNetworkCore.h"
@interface WXAFNetworkCore ()

@end
@implementation WXAFNetworkCore
static AFHTTPSessionManager *manager=nil;
+(AFHTTPSessionManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
           manager = [AFHTTPSessionManager manager];
        }
    });
    return manager;
}
/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getHttpRequestWithURL:(NSString *)urlString
                       params:(id)params
                 succeedBlock:(void(^)(id responseObj))succeedBlock
                    failBlock:(void(^)(id error))failBlock{
    AFHTTPSessionManager *manager = [WXAFNetworkCore shareManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            succeedBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
           failBlock(error);
        }
    }];
}
/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postHttpRequestWithURL:(NSString *)urlString
                        params:(id)params
                  succeedBlock:(void(^)(id responseObj))succeedBlock
                     failBlock:(void(^)(id error))failBlock{
    
    AFHTTPSessionManager *manager = [WXAFNetworkCore shareManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            succeedBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failBlock(error);
        }
    }];
    
}
//post请求-带进度
+ (void)postHttpRequestWithURL:(NSString *)urlString
                        params:(id)params
                 progressBlock:(void(^)(id downloadProgress))progressBlock
                  succeedBlock:(void(^)(id responseObj))succeedBlock
                     failBlock:(void(^)(id error))failBlock{
    AFHTTPSessionManager *manager = [WXAFNetworkCore shareManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval= 60.0;
    [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgress) {
            //progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            succeedBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failBlock(error);
        }
    }];
}
/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)unload:(NSString *)urlString parameters:(id)params filePath:(NSString *)filePath name:(NSString *)name imageData:(NSData *)imageData progress:(void (^)(NSProgress *))progressBlock success:(void (^)(id object))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:name fileName:filePath mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgress) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

/**
 *  下载数据
 *
 *  @param URLString   下载数据的网址
 *  @param parameters  下载数据的参数
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 */
- (void)downLoadWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                     progerss:(void (^)())progress
                      success:(void (^)())success
                      failure:(void (^)(NSError *error))failure{
    // 1 创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2 创建请求路径 请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    // 3 创建请求下载操作对象
    NSURLSessionDownloadTask *downTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return targetPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }else{
            success(filePath);
        }
    }];
    
    // 4 执行任务发送下载操作请求
    [downTask resume];
}
@end
