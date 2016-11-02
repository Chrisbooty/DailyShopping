//
//  CJHomeChildViewController.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJBaseViewController.h"
#import "CJHomeChildTableHeaderView.h"
#import "CJCollectionView.h"
#import "UIView+Convience.h"

@interface CJHomeChildCollectionViewController : CJBaseViewController <UICollectionViewDataSource>

/**
 URL
 */
@property (nonatomic, copy) NSString *URL;


/**
 collectionView
 */
@property (strong, nonatomic) CJCollectionView *collectionView;
/**
 collectionView数据源
 */
@property (nonatomic, strong) NSMutableArray *dataArrM;
/**
 collectionViewLayout
 */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

/**
 结束刷新
 */
- (void)endRefreshing;
/**
 设置上下拉刷新及网络字段
 */
- (void)setCollectionRefresh;

@end
