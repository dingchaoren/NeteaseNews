//
//  NewsM.m
//  新闻
//
//  Created by 丁超人 on 16/3/18.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "NewsM.h"
#import "NetworkTools.h"
#import "NSObject+Extension.h"
@implementation NewsM


// 把 NSArray 转换为 NSDictionary 在返回字符串
-(NSString *)description{
    NSArray *propertis = [self.class loadProperties];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    return [NSString stringWithFormat:@"<%@: %p> %@",self.class,self,dict];
}


+(void)loadNewsListWithURLString:(NSString *)urlString finished:(void (^)(NSArray *))finished{
    
    // 断言
    NSAssert(finished !=nil, @"必须传入完成回调");
    
    [[NetworkTools sharedNetworkTools]GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary *responseObject) {
        
        // url 不同  第一层字典的 key 不同
        // keyEnumerator.nextObject  利用他能够拿到第一个key
        // 主要用来遍历字典
        NSLog(@"%@",responseObject.keyEnumerator.nextObject);
        
        // 根据key 拿到第一个数组
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
//        NSLog(@"%@",array);
        
        // 字典转模型
        // Capacity 容量 假设是10  一次性分配10 个存储空间
        // 当添加到 11 个元素的时候，会再次开辟 10 个存储空间
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSDictionary *dict in array) {
            [arrayM addObject:[self objectWithDict:dict]];
        }
        // 直接回调
        finished(arrayM.copy);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
    @end
