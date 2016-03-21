//
//  ChannelCell.h
//  新闻
//
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsTableViewController;
@interface ChannelCell : UICollectionViewCell

// 加载新闻的 URL 字符串
@property(nonatomic, strong) NSString *urlString;

// 新闻视图控制器
@property(nonatomic, strong)NewsTableViewController *VC;

@end
