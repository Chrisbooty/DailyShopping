//
//  CJNetworking.m
//  CJNetworkingDemo
//
//  Created by Cijian on 2016/10/17.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#import "CJNetworking.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import <MBProgressHUD.h>
#import "UIView+Convience.h"

static NSMutableArray *tasks;

@implementation CJNetworking

+ (CJNetworking *)sharedCJNetworking
{
    static CJNetworking *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[CJNetworking alloc] init];
    });
    return handler;
}

+(NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DLog(@"创建数组");
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}


+(CJURLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(CJResponseSuccess)success
                           fail:(CJResponseFail)fail
                        showHUD:(BOOL)showHUD andController:(UIViewController*)acontroller
{
    
    return [self baseRequestType:1 url:url params:params success:success fail:fail showHUD:showHUD andController:acontroller];
    
}



+(CJURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(CJResponseSuccess)success
                            fail:(CJResponseFail)fail
                         showHUD:(BOOL)showHUD andController:(UIViewController*)acontroller{
    return [self baseRequestType:2 url:url params:params success:success fail:fail showHUD:showHUD andController:acontroller];
}

static BOOL isRequired = NO;
+(CJURLSessionTask *)baseRequestType:(NSUInteger)type
                                 url:(NSString *)url
                              params:(NSDictionary *)params
                             success:(CJResponseSuccess)success
                                fail:(CJResponseFail)fail
                             showHUD:(BOOL)showHUD andController:(UIViewController*)acontroller{
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (url==nil) {
        
        return nil;
    }
    
    if (isRequired) return nil;
    isRequired = YES;
    if (showHUD==YES) {
        [acontroller.view showLoading];
    }
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    CJURLSessionTask *sessionTask=nil;
    
    if (type==1) {
        
        sessionTask = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DLog(@"请求结果=%@",responseObject);
            
            
            if (success) {
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
            if (showHUD==YES) {
                [acontroller.view hideLoading];
            }
            isRequired = NO;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }
            
            [[self tasks] removeObject:sessionTask];
            
            if (showHUD==YES) {
                [acontroller.view hideLoading];
            }
            isRequired = NO;
        }];
        
    }else{
        
        sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DLog(@"请求成功=%@",responseObject);
            
            
            if ([responseObject[@"code"] intValue] == 40001) {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"LoginSuccess"];
                //                 [[NSUserDefaults standardUserDefaults] setObject:@"40001" forKey:@"UserNoLogin"];
                //                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserNoLogin"];
                //设置权限为消费者
                //                [[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:@"identity"];
                //
                //                UIAlertController * al = [UIAlertController alertControllerWithTitle:@"登录提示" message:@"对不起,您的账号在其他设备登录， 如不是本人操作，请及时修改密码!" preferredStyle:UIAlertControllerStyleAlert];
                //                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                //                    LoginViewController *Logined = [LoginViewController new];
                //                    Logined.states = @"3";
                //                    [acontroller presentViewController:Logined animated:NO completion:nil];
                //                }];
                //                [al addAction:okAction];
                //                UIAlertAction *okAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                //                    KHMainController *Logined = [KHMainController new];
                //                    [Logined tabBarConfig];
                //                    acontroller.view.window.rootViewController = Logined;
                //                }];
                //                [al addAction:okAction2];
                //                [acontroller presentViewController:al animated:YES completion:^{
                //
                //                }];
                
                
                
            }
            
            if (success) {
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
            if (showHUD==YES) {
                [acontroller.view hideLoading];
            }
            isRequired = NO;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }
            
            [[self tasks] removeObject:sessionTask];
            
            if (showHUD==YES) {
                [acontroller.view hideLoading];
            }
            isRequired = NO;
        }];
        
    }
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}

+(CJURLSessionTask *)uploadWithImage:(UIImage *)image
                                 url:(NSString *)url
                            filename:(NSString *)filename
                                name:(NSString *)name
                              params:(NSDictionary *)params
                            progress:(CJUploadProgress)progress
                             success:(CJResponseSuccess)success
                                fail:(CJResponseFail)fail
                             showHUD:(BOOL)showHUD{
    
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (url==nil) {
        return nil;
    }
    
    if (showHUD==YES) {
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
    }
    
    //检查地址中是否有中文
    NSString *urlStr = [NSURL URLWithString:url] ?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    CJURLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩图片
        NSData *imageData = UIImagePNGRepresentation(image);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.png", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/png\r\n\r\n"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功=%@",responseObject);
        if (success) {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:nil animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:nil animated:YES];
        }
        
    }];
    
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
    
}

+ (CJURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(CJDownloadProgress)progressBlock
                              success:(CJResponseSuccess)success
                              failure:(CJResponseFail)fail
                              showHUD:(BOOL)showHUD{
    
    
    DLog(@"请求地址----%@\n",url);
    if (url==nil) {
        return nil;
    }
    
    if (showHUD==YES) {
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self getAFManager];
    
    CJURLSessionTask *sessionTask = nil;
    
    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        DLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            DLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        DLog(@"下载文件成功");
        
        [[self tasks] removeObject:sessionTask];
        
        if (error == nil) {
            if (success) {
                success([filePath path]);//返回完整路径
            }
            
        } else {
            if (fail) {
                fail(error);
            }
        }
        
        if (showHUD==YES) {
            [MBProgressHUD hideHUDForView:nil animated:YES];
        }
        
    }];
    
    //开始启动任务
    [sessionTask resume];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
    
}

+(AFHTTPSessionManager *)getAFManager{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    
    return manager;
    
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                DLog(@"未知网络");
                [CJNetworking sharedCJNetworking].networkStats=StatusUnknown;
                
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                DLog(@"没有网络");
                [CJNetworking sharedCJNetworking].networkStats=StatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                DLog(@"手机自带网络");
                [CJNetworking sharedCJNetworking].networkStats=StatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [CJNetworking sharedCJNetworking].networkStats=StatusReachableViaWiFi;
                DLog(@"WIFI--%d",[CJNetworking sharedCJNetworking].networkStats);
                break;
        }
    }];
    [mgr startMonitoring];
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoringShowHUD2:(UIViewController*)aController
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                //                [aController.view showMsg:@"未知网络"];
            {  DLog(@"未知网络");
                [CJNetworking sharedCJNetworking].networkStats=StatusUnknown;
                
            } break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            { [aController.view showMsg:@"没有网络"];
                //                StatusNotReachableVC *vc = [StatusNotReachableVC new];
                //                vc.view.frame = CGRectMake(0, 64, k_width, k_height);
                //                UIButton *btn = (UIButton*)[vc.view viewWithTag:1];
                //                [btn addTarget:aController action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
                //                [aController.view addSubview:vc.view];
                DLog(@"没有网络");
                [CJNetworking sharedCJNetworking].networkStats=StatusNotReachable;
            }  break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            {   [aController.view showMsg:@"手机自带网络"];
                DLog(@"手机自带网络");
                [CJNetworking sharedCJNetworking].networkStats=StatusReachableViaWWAN;
            }  break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
            {
                [CJNetworking sharedCJNetworking].networkStats=StatusReachableViaWiFi;
                //                [aController.view showMsg:@"WIFI"];
                DLog(@"WIFI--%d",[CJNetworking sharedCJNetworking].networkStats);
            } break;
        }
    }];
    [mgr startMonitoring];
}


+(NSString *)strUTF8Encoding:(NSString *)str{
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


+(CJURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(CJResponseSuccess)success
                            fail:(CJResponseFail)fail
                        showHUD2:(UIView*)view{
    return [self baseRequestType:2 url:url params:params success:success fail:fail showHUD2:view];
}

+(CJURLSessionTask *)baseRequestType:(NSUInteger)type
                                 url:(NSString *)url
                              params:(NSDictionary *)params
                             success:(CJResponseSuccess)success
                                fail:(CJResponseFail)fail
                            showHUD2:(UIView*)view{
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (url==nil) {
        return nil;
    }
    
    if (view) {
        [view showLoading];
    }
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    CJURLSessionTask *sessionTask=nil;
    
    if (type==1) {
        sessionTask = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DLog(@"请求结果=%@",responseObject);
            if (success) {
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
            if (view) {
                [view hideLoading];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }
            
            [[self tasks] removeObject:sessionTask];
            
            if (view) {
                [view showMsg:@"加载失败"];
                [view hideLoading];
            }
            
        }];
        
    }else{
        
        sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DLog(@"请求成功=%@",responseObject);
            //            if ([responseObject[@"code"] intValue] == 40001) {
            //
            //                [[NSUserDefaults standardUserDefaults] setObject:@"40001" forKey:@"UserNoLogin"];
            //
            //
            //            }
            
            if (success) {
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
            if (view) {
                [view hideLoading];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }
            
            [[self tasks] removeObject:sessionTask];
            
            if (view) {
                [view hideLoading];
            }
            
        }];
        
    }
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}


@end
