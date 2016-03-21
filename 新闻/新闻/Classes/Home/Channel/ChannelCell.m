//  ChannelCell.m
//  新闻
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.

#import "ChannelCell.h"
#import "NewsTableViewController.h"

@interface ChannelCell ()


@end

@implementation ChannelCell

-(void)setUrlString:(NSString *)urlString{
    // 只负责将URLString 传递给 VC 。本身没有任何用处
//    _urlString = urlString;
    //设置新闻控制器的 URL
    self.VC.urlString = urlString;
}



// 从xib / sb 一加载就会执行
-(void)awakeFromNib {
    // 加载新闻控制器的视图
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.VC = sb.instantiateInitialViewController;
    
    // 添加视图
    [self addSubview:self. VC.view];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置大小
    self.VC.view.frame = self.bounds;
}
@end
