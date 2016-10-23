//
//  CJHomeChildTableViewController.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeChildTableViewController.h"
#import "CJHomeChildTableHeaderView.h"
#import "LXNetworking.h"
#import "CJHomeChildTableViewCell.h"
#import "CJTableView.h"

@interface CJHomeChildTableViewController () <UITableViewDelegate,UITableViewDataSource>

/** 
 tableView - CJHomeChildTableViewController 
 */
@property (weak, nonatomic) IBOutlet CJTableView *tableView;
/** 
 tableView - 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataArrM;
/**
 tableView 普通cell - 数据源
 */
@property (nonatomic, strong) NSMutableArray *commonModelArr;
/** 
 headerView 
 */
@property (nonatomic, weak) CJHomeChildTableHeaderView *headerView;



@end

static NSString * const commonID = @"CJHomeChildTableViewCell";

@implementation CJHomeChildTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取默认page值
    [self getDefaultPage];
    //设置contentInset，防止Tabbar遮住内容
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    //设置上下拉刷新控件
    [_tableView setTableViewRefreshWithController:self];
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"CJHomeChildTableViewCell" bundle:nil] forCellReuseIdentifier:commonID];
    _tableView.estimatedRowHeight = 300;
    
    [self requestCellData];
    [self createBannerView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

#pragma mark -获取默认page值
- (void)getDefaultPage
{
    self.page = 1;
}
#pragma mark -创建banner并获取数据
- (void)createBannerView
{
    //获取轮播图数据
    [LXNetworking getWithUrl:CJHomeCarouselURL params:nil success:^(id response) {
        
        NSArray *arr = response;
        NSMutableArray *bannerArrM = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            @autoreleasepool {
                CJHomeChildTableBannerModel *model = [CJHomeChildTableBannerModel yy_modelWithJSON:dict];
                if (model) {
                    [bannerArrM addObject:model];
                }
            }
        }
        //设置headerView
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CJHomeChildTableHeaderView" owner:nil options:nil] lastObject];
        _headerView.bannerModelArr = bannerArrM;
        _tableView.tableHeaderView = _headerView;
        
    } fail:^(NSError *error) {
        NSLog(@"---+++ %@",error);
    } showHUD:YES andController:self];
}
#pragma mark -tableView 获取数据
- (void)requestCellData
{
    CJWeakSelf
    [LXNetworking getWithUrl:[NSString stringWithFormat:CJHomeRecommandCellURL,self.page] params:nil success:^(id response) {
        //普通cell
        if (weakSelf.isUpRefresh) {
            [weakSelf.commonModelArr removeAllObjects];
        }
        NSArray *commonCellArr = response[@"goods_list"];
        for (NSDictionary *dict in commonCellArr) {
            CJHomeChildTableCellModel *model = [CJHomeChildTableCellModel yy_modelWithJSON:dict];
            if (model) {
                [self.commonModelArr addObject:model];
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf endRefreshing];
    } fail:^(NSError *error) {
        NSLog(@"-=-=-=-=-=%@",error);
        [weakSelf endRefreshing];
    } showHUD:NO andController:self];
}
- (void)endRefreshing
{
    CJWeakSelf
    [weakSelf.tableView.mj_header endRefreshing];
    [weakSelf.tableView.mj_footer endRefreshing];
}


#pragma mark - TableView dataSource function
#pragma mark -TableView --section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark -TableView --row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commonModelArr.count;
}
#pragma mark -TableView --cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJHomeChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commonID];
    
    cell.model = _commonModelArr[indexPath.row];
    
    return cell;
}

- (NSMutableArray *)dataArrM
{
    if (_dataArrM == nil) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}
- (NSMutableArray *)commonModelArr
{
    if (_commonModelArr == nil) {
        _commonModelArr = [NSMutableArray array];
    }
    return _commonModelArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
