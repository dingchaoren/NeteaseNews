//
//  NewsM.m
//  新闻
//
//  Created by 丁超人 on 16/3/18.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "NewsM.h"
#import "NetworkTools.h"
#import <objc/runtime.h>
@implementation NewsM

+(instancetype)newsWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    NSArray *propertis = [self loadProperties];

    for (NSString *key in propertis) {
        // 判断 key 是否存在
        
        if (dict[key] != nil ) {
            [obj setValue:dict[key] forKey:key];
        }
    }
    
//    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}
// 动态加载、类、的属性
const char *kProertiesKey = "kProertiesKey";
+(NSArray *)loadProperties {
    
    // 利用关联对象给类添加属性，OC中的类，本身就是一个特殊对象
    // 获取关联对象
    // 1 对象，属性相关联到的对象
    // 2 key 属性的key
    NSArray *pList = objc_getAssociatedObject(self, kProertiesKey);
    
    if (pList != nil) {
        return pList;
    }
    

    // 动态取属性列表
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
   
    NSLog(@"属性数量%u",count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (unsigned int i = 0 ; i < count; i++) {
        
        // C语言中没有对象的概念 一般不需要用*
        objc_property_t pty = list[i];
        
        // 属性名称
        const char *cname = property_getName(pty);
        // 添加到数组
        [arrayM addObject:[NSString stringWithUTF8String:cname]];
        
    }
    NSLog(@"%@",arrayM);
    // 释放对象
    free(list);
    
    // 设置关联对象对象
    // 1 属性关联的对象
    // 2 key
    // 3 值
    // 4 引用关系
    objc_setAssociatedObject(self, kProertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    
    return objc_getAssociatedObject(self, kProertiesKey);
}

// 把 NSArray 转换为 NSDictionary 在返回字符串
-(NSString *)description{
    NSArray *propertis = [self.class loadProperties];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    return [NSString stringWithFormat:@"<%@: %p> %@",self.class,self,dict];
}


+(void)loadNewsListWithURLString:(NSString *)urlString{
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
            [arrayM addObject:[self newsWithDict:dict]];
        }
        NSLog(@"%@",arrayM);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
    @end
