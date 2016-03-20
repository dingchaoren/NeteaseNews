//
//  DCNewsCell.h
//  新闻
//
//  Created by 丁超人 on 16/3/19.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsM;
@interface DCNewsCell : UITableViewCell

@property(nonatomic, strong) NewsM *news;

//可重用标示符号
+ (NSString *)cellIdentifier:(NewsM *)news;
@end
