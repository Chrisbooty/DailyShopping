//
//  CJShoppingController.m
//  DailyShopping
//
//  Created by Cijian on 2016/12/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJShoppingController.h"

@interface CJShoppingController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataArrM;

@end

@implementation CJShoppingController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [CJTool setTabbarWithController:self withImageName:@"oversea" withTitle:@"海淘"];
}

- (void)requestCellData
{
    [CJNetworking getWithUrl:[NSString stringWithFormat:CJShopping,_page] params:nil success:^(id response) {
        if (self.isUpRefresh) {
            [self.dataArrM removeAllObjects];
        }
        //
//        NSArray *
        
        
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataArrM
{
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}

@end
