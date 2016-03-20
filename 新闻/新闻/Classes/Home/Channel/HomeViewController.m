//
//  HomeViewController.m
//  新闻
//
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "HomeViewController.h"
#import "Channel.h"
@interface HomeViewController ()

// 频道数据
@property(nonatomic, strong) NSArray *channelList;
// 频道视图
@property (weak, nonatomic) IBOutlet UIScrollView *channelView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置频道
    [self setupChannel];

}
-(void)setupChannel {
    
    // 取消 scrollView 的自动缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 遍历频道数组 ，添加label
    for (Channel *channel in self.channelList) {
        
        UILabel *l = [[UILabel alloc]init];
        l.text = channel.tname;
        // 根据文字设定大小
        [l sizeToFit];
        
        [self.channelView addSubview:l];
    }
}

#pragma mark - 懒加载
-(NSArray *)channelList{
    if (_channelList == nil) {
        _channelList = [Channel channelList];
    }
    return _channelList;
}
@end
