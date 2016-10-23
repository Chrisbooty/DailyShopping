//
//  CJBaseViewController.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJURL.h"

@interface CJBaseViewController : UIViewController
{
    NSInteger _page;
    
}
/**
 网络请求page - 默认1
 */
@property (nonatomic, assign) NSInteger page;
/**
 是否上拉刷新
 */
@property (nonatomic, assign,getter=isUpRefresh) BOOL upRefresh;

/**
 刷新cell数据源
 */
- (void)requestCellData;

/**
 获取默认page或offset值
 */
- (void)getDefaultPage;

@end
