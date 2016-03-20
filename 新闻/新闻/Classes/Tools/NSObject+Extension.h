//
//  NSObject+Extension.h
//  新闻
//
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
// 字典转模型
+(instancetype)objectWithDict:(NSDictionary *)dict;
// 加载类的属性数组
+(NSArray *)loadProperties;
@end
