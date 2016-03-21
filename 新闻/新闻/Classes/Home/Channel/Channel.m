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

// 重写setter 方法，意味着对象的引用处理，全部由程序员接管
// 重写 copy 属性 在设置数值的时候，一定要写copy
-(void)setTid:(NSString *)tid{
    // 如果此处不适用copy 外面的copy 就白写了
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
    return [arrayM sortedArrayUsingComparator:^NSComparisonResult(Channel * obj1, Channel * obj2) {
        
        return [obj1.tid compare:obj2.tid];
        
    }];
}
//description  不要抽取，放在各自的类中。写不好会死循环，影响性能
-(NSString *)description{
    NSArray *propertis = [self.class loadProperties];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    return [NSString stringWithFormat:@"<%@: %p> %@",self.class,self,dict];
}

@end
