//
//  LZCycleCollectionView.h
//  无限分页
//
//  Created by 刘梓颖 on 16/4/26.
//  Copyright © 2016年 lzing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZCycleCollectionView;

@protocol LZCycleCollectionViewDelegate <NSObject>

@optional

///  点击图片回调
- (void)cycleCollectionView:(LZCycleCollectionView *)cycleCollectionView didSelectItemAtIndex:(NSInteger)index;

@end

@interface LZCycleCollectionView : UICollectionView

///  图片数组
@property(nonatomic, strong) NSArray *imageArr;

///  代理
@property (nonatomic, weak) id<LZCycleCollectionViewDelegate> cycleDelegate;

///  设置时间间隔(默认2S)
@property (nonatomic, assign) NSTimeInterval timeInterval;

///  快速工厂方法
+ (instancetype)cycleCollectionViewWithImageArr:(NSArray *)imageArr;

///  快速工厂方法
- (instancetype)initWithImageArr:(NSArray *)imageArr;

///  清除图片缓存
+ (void)clearImagesCache;

@end
