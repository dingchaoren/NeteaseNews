//
//  DCNewsCell.m
//  新闻
//
//  Created by 丁超人 on 16/3/19.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "DCNewsCell.h"
#import "NewsM.h"
// AFN针对 UIImageView 的分类
#import <UIImageView+AFNetworking.h>

@interface DCNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@end

@implementation DCNewsCell

-(void)setNews:(NewsM *)news {
    _news = news;
    self.titleLabel.text = news.title;
    self.digestLabel.text = news.digest;
    self.replyLabel.text = [NSString stringWithFormat:@"%d",news.replyCount];
    // 设置图像 - AFN的图像分类不支持 GIF，绝大多数还是应该用 SDWebImage
    [self.iconView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
    
}


- (void)awakeFromNib {

// 设置换行宽度
    self.digestLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.iconView.frame) - 16;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
