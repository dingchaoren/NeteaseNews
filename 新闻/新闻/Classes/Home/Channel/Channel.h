//
//  Channel.h
//  新闻
//
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property(nonatomic, copy) NSString *tname;
@property(nonatomic, copy) NSString *tid;

// 只能内部使用，外部只读
@property(nonatomic, strong, readonly) NSString *urlString;


+(NSArray *)channelList;
@end
