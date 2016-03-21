 //
//  HomeViewController.m
//  新闻
//
//  Created by 丁超人 on 16/3/20.
//  Copyright © 2016年 丁超人. All rights reserved.
//

#import "HomeViewController.h"
#import "Channel.h"
#import "channelLabel.h"
#import "ChannelCell.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

// 频道数据
@property(nonatomic, strong) NSArray *channelList;
// 频道视图
@property (weak, nonatomic) IBOutlet UIScrollView *channelView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置频道
    [self setupChannel];

}

//子视图已经布局完成
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    // 设置布局
    [self setupLayout];
}

-(void)setupLayout{
    
    self.layout.itemSize = self.collectionView.bounds.size;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 允许分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    
    
    
}
#pragma mark - 数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channelList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChannelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255.0) green:((float)arc4random_uniform(256)/255.0) blue:((float)arc4random_uniform(256)/255.0) alpha:1.0];
    
    // 设置URL String
    cell.urlString = [self.channelList[indexPath.item]urlString];
    
    return cell;
}

-(void)setupChannel {
    
    // 取消 scrollView 的自动缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 遍历频道数组 ，添加label
    CGFloat margin = 8.0;
    CGFloat x = margin;
    CGFloat h = self.channelView.bounds.size.height;
    
    for (Channel *channel in self.channelList) {
        
        channelLabel *l = [channelLabel channeLabelWithTitle:channel.tname];
        
        // 设置位置
        l.frame = CGRectMake(x, 0, l.bounds.size.width, h);
        // 递增
        x += l.bounds.size.width;
        
        [self.channelView addSubview:l];
    }
    // 设置contenSize
    self.channelView.contentSize = CGSizeMake(x + margin, h);
}

#pragma mark - 懒加载
-(NSArray *)channelList{
    if (_channelList == nil) {
        _channelList = [Channel channelList];
    }
    return _channelList;
}
@end
