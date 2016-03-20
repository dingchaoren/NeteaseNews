//
//  NewsM.h
//  新闻
//
//  Created by 丁超人 on 16/3/18.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsM : NSObject
//title
//digest
//replyCount
//imgsrc

// 新闻标题
@property(nonatomic, copy) NSString *title;
// 新闻摘要
@property(nonatomic, copy) NSString *digest;
// 更贴数量
@property(nonatomic, assign) int replyCount;
// 配图地址
@property(nonatomic, copy) NSString *imgsrc;
// 多图数组
@property(nonatomic, strong) NSArray *imgextra;
//是否大图标记
@property(nonatomic, assign, getter=isBigImage) BOOL imgType;

// 加载指定URL 的新闻数组
+(void)loadNewsListWithURLString:(NSString *)urlString finished:(void(^)(NSArray *newsList))finished;
@end
