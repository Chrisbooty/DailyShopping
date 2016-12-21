//
//  CJHomeChildTableViewController.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeChildTableViewController.h"
#import "CJHomeChildTableHeaderView.h"
#import "CJNetworking.h"
#import "CJHomeChildTableViewCell.h"
#import "CJTableView.h"
#import "CJRecommandTableCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

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
/**
 是否加载过推荐cell
 */
@property (nonatomic, assign,getter=isLoadRecom) BOOL loadRecom;

@end

static NSString * const commonID = @"CJHomeChildTableViewCell";
static NSString * const recommandID = @"CJRecommandTableCell";

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
    [_tableView registerNib:[UINib nibWithNibName:commonID bundle:nil] forCellReuseIdentifier:commonID];
    [_tableView registerNib:[UINib nibWithNibName:recommandID bundle:nil] forCellReuseIdentifier:recommandID];
    
    [self createBannerView];
    [self requestCellData];
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
    [CJNetworking getWithUrl:CJHomeCarouselURL params:nil success:^(id response) {
        
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
        CGRect tempRect = _headerView.frame;
        tempRect.size.height = CWidth * 17/24 + 160;
        _headerView.frame = tempRect;
        _tableView.tableHeaderView = _headerView;
    } fail:^(NSError *error) {
        NSLog(@"---+++ %@",error);
    } showHUD:YES andController:self];
}
#pragma mark -tableView 获取数据
- (void)requestCellData
{
    
    CJWeakSelf
    [CJNetworking getWithUrl:[NSString stringWithFormat:CJHomeRecommandCellURL,weakSelf.page] params:nil success:^(id response) {
        //普通cell
        if (weakSelf.isUpRefresh) {
            weakSelf.loadRecom = NO;
            [weakSelf.dataArrM removeAllObjects];
        }
        NSArray *commonCellArr = response[@"goods_list"];
        for (NSDictionary *dict in commonCellArr) {
            @autoreleasepool {
                CJHomeChildTableCellModel *model = [CJHomeChildTableCellModel yy_modelWithJSON:dict];
                if (model) {
                    [self.dataArrM addObject:model];
                }
            }
        }
        //推荐内容cell
        if (!self.isLoadRecom) {
            NSArray *recommandArr = response[@"home_recommend_subjects"];
            for (NSDictionary *dict in recommandArr) {
                @autoreleasepool {
                    CJRecommandGroupModel *groupModel = [CJRecommandGroupModel yy_modelWithDictionary:dict];
                    if (groupModel) {
                        [weakSelf.dataArrM insertObject:groupModel atIndex:groupModel.position];
                    }
                }
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf endRefreshing];
    } fail:^(NSError *error) {
        NSLog(@"-=-=-=-=-=%@",error);
        [weakSelf endRefreshing];
    } showHUD:NO andController:weakSelf];
}
#pragma mark -结束上下拉刷新
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
    return self.dataArrM.count;
}
#pragma mark -TableView --cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _dataArrM[indexPath.row];
    if ([model isKindOfClass:[CJHomeChildTableCellModel class]]) {
        
        CJHomeChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commonID];
        
        cell.model = model;
        return cell;
    }else if ([model isKindOfClass:[CJRecommandGroupModel class]])
    {
        CJRecommandTableCell *cell = [tableView dequeueReusableCellWithIdentifier:recommandID];
        cell.model = model;
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _dataArrM[indexPath.row];
    if ([model isKindOfClass:[CJHomeChildTableCellModel class]]) {
        
        return [tableView fd_heightForCellWithIdentifier:commonID configuration:^(CJHomeChildTableViewCell *cell) {
            cell.model = model;
        }];
        
    }else if ([model isKindOfClass:[CJRecommandGroupModel class]])
    {

        return [tableView fd_heightForCellWithIdentifier:recommandID configuration:^(CJRecommandTableCell *cell) {
            cell.model = model;
        }];
    }
    return 0;
}

#pragma mark -懒加载
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
