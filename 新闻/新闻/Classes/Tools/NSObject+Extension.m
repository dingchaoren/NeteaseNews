//
//  NSObject+Extension.m
//  新闻
//
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>
@implementation NSObject (Extension)

+(instancetype)objectWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    NSArray *propertis = [self loadProperties];
    
    for (NSString *key in propertis) {
        // 判断 key 是否存在
        
        if (dict[key] != nil ) {
            [obj setValue:dict[key] forKey:key];
        }
    }
    
    return obj;
}

#pragma mark - 运行时方法
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

@end
