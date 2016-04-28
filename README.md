# LZCycleCollectionView
# 最省内存的collectionView版图片轮播
## 目前还不能快捷添加pageControll,有需要的话可能要自己添加

###使用方法在控制器中进行配置,导入cell和view两个文件就可以了
     // 创建view
     LZCycleCollectionView *cycleCV = [[LZCycleCollectionView alloc] init];
          
     // 添加view
     cycleCV.frame = CGRectMake(0, 0, 300, 300);
     
     // 设置图片(传递一个数组, 可以是网址,本地图片, png, jpg)
     cycleCV.imageArr = self.imageArray;
     
     // 添加view
     [self.view addSubview:cycleCV];
     
     #基本使用就四句话,或者说两句话,创建的时候使用工厂方法
     cycleCV = [LZCycleCollectionView cycleCollectionViewWithImageArr:self.img];
     或者
     cycleCV = [[LZCycleCollectionView alloc] initWithImageArr:self.img];
     
     // 当然需要添加pageControl的话还需要再加两句
     self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.cycleCV.frame) - 50, CGRectGetWidth(self.cycleCV.frame), 50);
    [self.view addSubview:self.pageControl];
     
     #高级点的功能呢有设置滚动时间(默认2.0s)
     cycleCV.timeInterval = 1;
    
     代理<LZCycleCollectionViewDelegate>
     cycleCV.cycleDelegate = self;
     
     ///  点击了cycleCollectionView
     - (void)cycleCollectionView:(LZCycleCollectionView *)cycleCollectionView didSelectItemAtIndex:(NSInteger)index
     
     ///  滚动了cycleCollectionView,返回pageContol的当前数目
     - (void)cycleCollectionView:(LZCycleCollectionView *)cycleCollectionView didScrollItemAtIndex:(NSInteger)index