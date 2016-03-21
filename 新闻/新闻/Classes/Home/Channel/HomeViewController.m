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


// 当前选中的索引
@property(nonatomic, assign) NSInteger currentIndex;
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
    
    //******在用代码开发时，如果出现多图控制器的情况，一定要注意添加自控制器
    // 提示：在当前的代码中不会出现问题，但一定要加
    // 否则；响应者链条的传递会出问题，会出现很莫名奇妙的情况
    // 控制器一定要知道内部的所有细节
    
    // 判断是否已经添加子控制器
//   Incompatible pointer types sending 'NewsTableViewController *' to parameter of type '__kindof UIViewController * _Nonnull'
    if (![self.childViewControllers containsObject:(UIViewController *)cell.VC]) {
        [self addChildViewController:(UIViewController *)cell.VC];
    }
    
    NSLog(@"%@",self.childViewControllers);
    
    return  cell;
}
#pragma mark -ScrollView 的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%s",__FUNCTION__);
    // 1 当前选中的标签
    channelLabel *currentLabel = self.channelView.subviews[self.currentIndex];
//    NSLog(@"当前的%@",currentLabel.text);
    // 下一个标签
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
//    NSLog(@"%@",indexPaths);
    // 遍历数组，确定第二标签
    channelLabel *nextLabel = nil;
    for (NSIndexPath *path in indexPaths) {
        if (path.item != self.currentIndex) {
            nextLabel = self.channelView.subviews[path.item];
            break;
        }
    }
    NSLog(@"从%@ 到%@",currentLabel.text, nextLabel.text);
// 3 判断是否有下一个标签
    if (nextLabel == nil) {
        return;
    }
// 4   比例 0~1
    float nextScale = ABS((float)self.collectionView.contentOffset.x / self.collectionView.bounds.size.width - self.currentIndex);
    
    float currentScale = 1 - nextScale;
    
    NSLog(@"%f  %f",currentScale, nextScale);

    // 设置比例
    currentLabel.scale = currentScale;
    nextLabel.scale = nextScale;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 更新当前索引
    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
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
    
    // 当前选中第0项
    self.currentIndex = 0;
    
    // 设置第0 个label de scale
    channelLabel *l = self.channelView.subviews[0];
    l.scale = 1;

}

#pragma mark - 懒加载
-(NSArray *)channelList{
    if (_channelList == nil) {
        _channelList = [Channel channelList];
    }
    return _channelList;
}
@end
