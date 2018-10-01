//
//  WXAFNetworkCore.h
//  NobuhiroCredit
//
//  Created by wangxia on 16/7/8.
//  Copyright © 2016年 wangxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface WXAFNetworkCore : NSObject
+(AFHTTPSessionManager *)shareManager;
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
                    failBlock:(void(^)(id error))failBlock;
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
                     failBlock:(void(^)(id error))failBlock;

//post请求--带进度
+ (void)postHttpRequestWithURL:(NSString *)urlString
                        params:(id)params
                 progressBlock:(void(^)(id downloadProgress))progressBlock
                  succeedBlock:(void(^)(id responseObj))succeedBlock
                     failBlock:(void(^)(id error))failBlock;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)unload:(NSString *)urlString parameters:(id)params filePath:(NSString *)filePath name:(NSString *)name imageData:(NSData *)imageData progress:(void (^)(NSProgress *))progress success:(void (^)(id object))success failure:(void (^)(NSError *))failure;

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
                      failure:(void (^)(NSError *error))failure;
@end
