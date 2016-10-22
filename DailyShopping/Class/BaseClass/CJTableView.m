//
//  CJTableView.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/22.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJTableView.h"
#import "CJHeader.h"
#import <MJRefresh.h>


@implementation CJTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark -设置上下拉刷新
- (void)setTableViewRefreshWithController:(CJBaseViewController *)controller
{
    //设置上拉刷新
    __weak CJBaseViewController *weakSelf = controller;
    MJRefreshHeader *header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDefaultPage];
        weakSelf.upRefresh = YES;
        [weakSelf requestCellData];
    }];
    self.mj_header = header;
    //设置下拉刷新
    MJRefreshFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        weakSelf.upRefresh = NO;
        [weakSelf requestCellData];
    }];
    
    self.mj_footer = footer;
}

@end
