//
//  CJCollectionView.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/23.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJBaseViewController.h"
@interface CJCollectionView : UICollectionView

/**
 设置collectionView上下拉刷新
 
 @param controller 控制器
 */
- (void)setCollectionViewRefreshWithController:(CJBaseViewController *)controller;

@end
