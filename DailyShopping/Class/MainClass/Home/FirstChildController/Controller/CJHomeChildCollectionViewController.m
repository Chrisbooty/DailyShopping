//
//  CJHomeChildViewController.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeChildCollectionViewController.h"
#import "LXNetworking.h"
#import "CJHomeChildCollectionCell.h"
#import "CJCollectionView.h"


static NSString * const ID = @"CJHomeChildCollectionCell";

static CGFloat const column = 2;

@interface CJHomeChildCollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**
 collectionView
 */
@property (strong, nonatomic) CJCollectionView *collectionView;
/** 
 collectionView数据源 
 */
@property (nonatomic, strong) NSMutableArray *dataArrM;

@end

@implementation CJHomeChildCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    _page = 0;
    
    //创建FlowLayout
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    CGFloat itemW = (CWidth-1) / column;
    CGFloat itemH = itemW + 100;
    flowLayout.itemSize = CGSizeMake(itemW , itemH);
    //创建collectionView
    _collectionView = [[CJCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView setCollectionViewRefreshWithController:self];
    
    [self.view addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"CJHomeChildCollectionCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    [self requestCellData];
}

- (void)requestCellData
{
    CJWeakSelf
    [LXNetworking getWithUrl:[NSString stringWithFormat:self.URL,self.page] params:nil success:^(id response) {
        //普通cell
        if (weakSelf.isUpRefresh) {
            [weakSelf.dataArrM removeAllObjects];
        }
        NSArray *commonCellArr = response[@"goods_list"];
        for (NSDictionary *dict in commonCellArr) {
            CJHomeCollectionModel *model = [CJHomeCollectionModel yy_modelWithJSON:dict];
            if (model) {
                [self.dataArrM addObject:model];
            }
        }
        [weakSelf.collectionView reloadData];
        [weakSelf endRefreshing];
    } fail:^(NSError *error) {
        NSLog(@"-=-=-=-=-=%@",error);
        [weakSelf endRefreshing];
    } showHUD:NO andController:self];
}
#pragma mark -结束刷新
- (void)endRefreshing
{
    CJWeakSelf
    [weakSelf.collectionView.mj_header endRefreshing];
    [weakSelf.collectionView.mj_footer endRefreshing];
}
#pragma mark - CollectionView delegate function
#pragma mark -CollectionView --section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark -CollectionView --row
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArrM.count;
}
#pragma mark -CollectionView --cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CJHomeChildCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.model = _dataArrM[indexPath.row];
    
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
