//
//  channelLabel.h
//  新闻
//
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface channelLabel : UILabel

+(instancetype)channeLabelWithTitle:(NSString *)title;

// 从 0~1 0是14号字  1是18号
@property(nonatomic, assign)float scale;
@end
