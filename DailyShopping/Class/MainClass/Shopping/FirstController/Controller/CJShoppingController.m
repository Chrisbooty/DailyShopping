//
//  CJShoppingController.m
//  DailyShopping
//
//  Created by Cijian on 2016/12/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJShoppingController.h"
#import "CJHomeChildTableViewCell.h"
#import "CJTableView.h"
#import "CJRecommandTableCell.h"
#import "CJShoppingHeaderView.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface CJShoppingController ()

@property (weak, nonatomic) IBOutlet CJTableView *tableView;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataArrM;
/**
 是否加载过推荐cell
 */
@property (nonatomic, assign,getter=isLoadRecom) BOOL loadRecom;

@end

@implementation CJShoppingController

static NSString * const commonID = @"CJHomeChildTableViewCell";
static NSString * const recommandID = @"CJRecommandTableCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [CJTool setTabbarWithController:self withImageName:@"oversea" withTitle:@"海淘"];
}

- (void)requestCellData
{
    CJWeakSelf;
    [CJNetworking getWithUrl:[NSString stringWithFormat:CJShopping,_page] params:nil success:^(id response) {

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
                        if (self.dataArrM.count > groupModel.position) {
                            [self.dataArrM insertObject:groupModel atIndex:groupModel.position];
                        }
                    }
                }
            }
        }
        
        [weakSelf.tableView reloadData];
        [self endRefreshing];
    } fail:^(NSError *error) {
        [self endRefreshing];
    } showHUD:nil andController:nil];
}

- (void)endRefreshing
{
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:commonID bundle:nil] forCellReuseIdentifier:commonID];
    [_tableView registerNib:[UINib nibWithNibName:recommandID bundle:nil] forCellReuseIdentifier:recommandID];
    //设置上下拉刷新控件
    [_tableView setTableViewRefreshWithController:self];
    
    [self requestCellData];
    _tableView.tableHeaderView = [CJShoppingHeaderView view];
}

#pragma mark - TableView 数据源方法
#pragma mark -TableView --段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark -TableView --行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArrM.count;
}
#pragma mark -TableView --cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _dataArrM[indexPath.row];
    NSString *ID = [model isKindOfClass:[CJHomeChildTableCellModel class]] ? commonID : recommandID;
    CJHomeChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _dataArrM[indexPath.row];
    NSString *ID = [model isKindOfClass:[CJHomeChildTableCellModel class]] ? commonID : recommandID;
    return [tableView fd_heightForCellWithIdentifier:ID configuration:^(CJRecommandTableCell *cell) {
        cell.model = model;
    }];
}

- (NSMutableArray *)dataArrM
{
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
