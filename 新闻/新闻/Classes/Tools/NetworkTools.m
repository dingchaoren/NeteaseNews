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
    });
    return instance;
}

@end
