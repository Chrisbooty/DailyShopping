//
//  CJCollectionView.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/23.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJCollectionView.h"
#import "CJHeader.h"
#import <MJRefresh.h>

@implementation CJCollectionView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:246/255.0];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:246/255.0];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark -设置上下拉刷新
- (void)setCollectionViewRefreshWithController:(CJBaseViewController *)controller isPage:(BOOL)isPage
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
    NSInteger num = isPage ? 1:50;
    
    MJRefreshFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page = weakSelf.page + num;
        weakSelf.upRefresh = NO;
        [weakSelf requestCellData];
    }];
    
    self.mj_footer = footer;
    
}

@end
