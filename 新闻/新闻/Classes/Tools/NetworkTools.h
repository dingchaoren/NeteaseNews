//
//  NetworkTools.h
//  新闻
//
//  Created by 丁超人 on 16/3/18.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkTools : AFHTTPSessionManager
// 单例 全局访问入口
+(instancetype)sharedNetworkTools;

@end
