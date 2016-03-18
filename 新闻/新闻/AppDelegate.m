//
//  AppDelegate.m
//  新闻
//
//  Created by 丁超人 on 16/3/18.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   // 1 设置缓存 MemoryCapacity 内存容量   diskCapacity磁盘容量
    NSURLCache *cache = [[NSURLCache alloc]initWithMemoryCapacity:4 * 1024 *1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    
    [NSURLCache setSharedURLCache:cache];
    
   // 2 设置网络指示器 后续的网络请求都会显示小菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
    return YES;
}


@end
