//
//  channelLabel.m
//  新闻
//
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "channelLabel.h"

@implementation channelLabel
#define DCNormalFontSize 14.0
#define DCSelectedFontSize 18.0
+(instancetype)channeLabelWithTitle:(NSString *)title{
    channelLabel *lb = [[channelLabel alloc]init];
    lb.text = title;
    
    // 文本对齐方式
    lb.textAlignment = NSTextAlignmentCenter;
    
    // 设置大字体。预留出左右的间距
    lb.font = [UIFont systemFontOfSize:DCSelectedFontSize];
    
    [lb sizeToFit];
    
    // 设置成小字体
    lb.font = [UIFont systemFontOfSize:DCNormalFontSize];
    
    return lb;
    
}
@end
