//
//  NetworkTools.m
//  新闻
//
//  Created by 丁超人 on 16/3/18.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools
+(instancetype)sharedNetworkTools{
    
    static NetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/article/headline/"];
        instance = [[self alloc]initWithBaseURL:url];
        
        // 添加响应解析的数据格式   反序列化
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return instance;
}

@end
