//
//  CJTableView.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/22.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJBaseViewController.h"

@interface CJTableView : UITableView

/**
 设置tableView上下拉刷新

 @param controller 控制器
 */
- (void)setTableViewRefreshWithController:(CJBaseViewController *)controller;

@end
