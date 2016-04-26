//
//  LZCycleCollectionView.m
//  无限分页
//
//  Created by 刘梓颖 on 16/4/26.
//  Copyright © 2016年 lzing. All rights reserved.
//

#import "LZCycleCollectionView.h"
#import "LZCycleCell.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"

@interface LZCycleCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end

static NSString * const resuableID = @"cell";

@implementation LZCycleCollectionView

+ (instancetype)cycleCollectionViewWithImageArr:(NSArray *)imageArr {
    return [[self alloc] initWithImageArr:imageArr];
}

- (instancetype)initWithImageArr:(NSArray *)imageArr {
    if (self = [super init]) {
        self.imageArr = imageArr;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        self.delegate = self;
        self.dataSource = self;
        [self setupCollectionView];
    }
    return self;
}

- (void)setupCollectionView {
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.backgroundColor = [UIColor whiteColor];
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self registerClass:[LZCycleCell class] forCellWithReuseIdentifier:resuableID];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if ((frame.size.width <=0 || frame.size.height <= 0)) {
        return;
    }
    self.flowLayout.itemSize = frame.size;
    [self scrollToSecondCell];
}

#pragma mark - <TimerMethod>
- (void)addTimer {
    NSTimeInterval timeInterval = self.timeInterval ? self.timeInterval : 2.0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)scrollImage {
    CGFloat index = 2 * self.bounds.size.width;
    [self setContentOffset:CGPointMake(index, 0) animated:YES];
}

#pragma mark - <privateMethod>
- (void)scrollToSecondCell {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    });
}

#pragma mark - <UICollectionViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = (self.currentIndex + self.imageArr.count - 1 + indexPath.item) % (self.imageArr.count);
    if ([self.cycleDelegate respondsToSelector:@selector(cycleCollectionView:didSelectItemAtIndex:)]) {
        [self.cycleDelegate cycleCollectionView:self didSelectItemAtIndex:index];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSTimeInterval timeInterval = self.timeInterval ? self.timeInterval : 2.0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger offset = self.contentOffset.x / self.bounds.size.width - 1;
    
    if (offset == 0) {
        return;
    }
    
    self.currentIndex = (self.currentIndex + offset + self.imageArr.count) % (self.imageArr.count);
    [self scrollToSecondCell];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger offset = self.contentOffset.x / self.bounds.size.width - 1;
    
    if (offset == 0 || self.imageArr.count == 0) {
        return;
    }
    
    self.currentIndex = (self.currentIndex + offset + self.imageArr.count) % (self.imageArr.count);
    [self scrollToSecondCell];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LZCycleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:resuableID forIndexPath:indexPath];
    
    if (self.imageArr.count == 0) {
        return cell;
    }
    
    NSInteger index = (self.currentIndex + self.imageArr.count - 1 + indexPath.item) % (self.imageArr.count);
    cell.imagePath = self.imageArr[index];
    return cell;
}

#pragma mark - <setter>
- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;
    if (_imageArr == nil || _imageArr.count == 0) {
        return;
    }
    [self scrollToSecondCell];
    [self addTimer];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - <clearImagesCache>
+ (void)clearImagesCache {
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
}

@end
