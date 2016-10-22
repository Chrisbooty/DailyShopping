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
#import <YYModel/YYModel.h>

@interface CJHomeChildTableViewController () <UITableViewDelegate,UITableViewDataSource>

/** tableView - CJHomeChildTableViewController */
@property (weak, nonatomic) IBOutlet UITableView *tableView;


/** tableView - 数据源 */
@property (nonatomic, strong) NSMutableArray *dataArrM;

/** headerView */
@property (nonatomic, weak) CJHomeChildTableHeaderView *headerView;

@end

@implementation CJHomeChildTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    //创建tableView
    //    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //    _tableView.delegate = self;
    //    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
    
//    [self createBannerView];
    
    //设置contentInset，防止Tabbar遮住内容
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self createBannerView];
}



#pragma mark -创建banner并获取数据
- (void)createBannerView
{
    //设置headerView
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CJHomeChildTableHeaderView" owner:nil options:nil] lastObject];
    _tableView.tableHeaderView = _headerView;
    
    //获取轮播图数据
    [LXNetworking getWithUrl:CJHomeCarouselURL params:nil success:^(id response) {
        
        NSArray *arr = response;
        
        for (NSDictionary *dict in arr) {
            @autoreleasepool {
                CJHomeChildTableBannerModel *model = [CJHomeChildTableBannerModel yy_modelWithJSON:dict];
                if (model) {
                    [self.dataArrM addObject:model];
                }
            }
        }
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CJHomeChildTableHeaderView" owner:nil options:nil] lastObject];
        
        _headerView.bannerModelArr = _dataArrM;
        _tableView.tableHeaderView = _headerView;
        
    } fail:^(NSError *error) {
        NSLog(@"---+++ %@",error);
    } showHUD:YES andController:self];
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
    //    return self.dataArrM.count;
    return 10;
}
#pragma mark -TableView --cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (NSMutableArray *)dataArrM
{
    if (_dataArrM == nil) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
