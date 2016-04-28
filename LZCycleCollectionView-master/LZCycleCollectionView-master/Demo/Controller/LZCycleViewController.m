//
//  LZCycleViewController.m
//  无限分页
//
//  Created by 刘梓颖 on 16/4/26.
//  Copyright © 2016年 lzing. All rights reserved.
//

#import "LZCycleViewController.h"
#import "LZCycleCollectionView.h"

@interface LZCycleViewController ()<LZCycleCollectionViewDelegate>

@property (nonatomic, strong) NSArray *img;

@property (nonatomic, strong) LZCycleCollectionView *cycleCV;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation LZCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.cycleCV];
    self.cycleCV.frame = CGRectMake(0, 0, 300, 300);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.cycleCV.frame) - 50, CGRectGetWidth(self.cycleCV.frame), 50);
    [self.view addSubview:self.pageControl];
}

#pragma mark - LZCycleCollectionViewDelegate
///  点击了cycleCollectionView
- (void)cycleCollectionView:(LZCycleCollectionView *)cycleCollectionView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
}

///  滚动了cycleCollectionView
- (void)cycleCollectionView:(LZCycleCollectionView *)cycleCollectionView didScrollItemAtIndex:(NSInteger)index {
    self.pageControl.currentPage = index;
}

#pragma mark - lazy
//- (NSArray *)img{
//    if (_img == nil) {
//        NSMutableArray * arr = [NSMutableArray array];
//        for (int i = 0; i < 9; i++) {
//            [arr addObject:[NSString stringWithFormat:@"%d",i]];
//        }
//        _img = arr;
//    }
//    return _img;
//}

//- (NSArray *)img{
//    if (_img == nil) {
//        _img = @[
//          @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//          @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//          @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
//          @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//          @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//          @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
//          @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//          @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//          @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
//          @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//          @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//          @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//          ];
//    }
//    return _img;
//}

- (NSArray *)img{
    if (_img == nil) {
        NSMutableArray * arr = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            NSString *imgName = [NSString stringWithFormat:@"%d.jpg",i + 1];
            NSString * path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
            [arr addObject:path];
        }
        _img = arr;
    }
    return _img;
}

- (LZCycleCollectionView *)cycleCV {
    if (_cycleCV == nil) {
//        _cycleCV = [[LZCycleCollectionView alloc] init];
//        _cycleCV = [LZCycleCollectionView cycleCollectionViewWithImageArr:self.img];
        _cycleCV = [[LZCycleCollectionView alloc] initWithImageArr:self.img];
//        _cycleCV.imageArr = self.img;
        _cycleCV.timeInterval = 1;
        _cycleCV.cycleDelegate = self;
    }
    return _cycleCV;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = self.img.count;
    }
    return _pageControl;
}

@end
