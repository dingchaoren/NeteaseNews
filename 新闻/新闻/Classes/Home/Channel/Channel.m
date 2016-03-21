//
//  Channel.m
//  新闻
//
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "Channel.h"
#import "NSObject+Extension.h"
@implementation Channel

-(void)setTid:(NSString *)tid{
    _tid = tid.copy;
    _urlString = [NSString stringWithFormat:@"%@/0-20.html",_tid];
}

+(NSArray *)channelList{
    // 1 加载 json 的二进制数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    // 2 反序列化
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    // 3 从字典中得到数据
    NSArray *array = dict[dict.keyEnumerator.nextObject];
    // 4 遍历数组，字典转模型
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *obj in array) {
        [arrayM addObject:[self objectWithDict:obj]];
    }
    
    // 5 针对tid 做一个排序
    return arrayM.copy;
}
//description  不要抽取，放在各自的类中。写不好会死循环，影响性能
-(NSString *)description{
    NSArray *propertis = [self.class loadProperties];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    return [NSString stringWithFormat:@"<%@: %p> %@",self.class,self,dict];
}

@end
