//
//  CJHomeChildViewController.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeChildCollectionViewController.h"
#import "CJHomeChildCollectionCell.h"


//cell 重用ID
static NSString * const ID = @"CJHomeChildCollectionCell";
//collectionView 列数
static CGFloat const column = 2;

@interface CJHomeChildCollectionViewController () <UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation CJHomeChildCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _page = 0;
    [self.view showLoading];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadCollectionView];
    
    [self setCollectionRefresh];
}
#pragma mark - 加载collectionView
- (void)loadCollectionView
{
    //创建FlowLayout
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.minimumLineSpacing = 1;
    _flowLayout.minimumInteritemSpacing = 1;
    CGFloat itemW = (CWidth - 1) / column;
    //图片底部的高为80
    CGFloat itemH = itemW + 80;
    _flowLayout.itemSize = CGSizeMake(itemW , itemH);
    //创建collectionView
    _collectionView = [[CJCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellWithReuseIdentifier:ID];
    //调整contentInset，使内容不被Tabbar遮住
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    [self requestCellData];
}
#pragma mark -设置上下拉刷新及网络字段
- (void)setCollectionRefresh
{
    //设置上下拉刷新
    [_collectionView setCollectionViewRefreshWithController:self isPage:NO];
}

#pragma mark -collectionView网络请求
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
        [weakSelf.view hideLoading];
    } fail:^(NSError *error) {
        NSLog(@"-=-=-=-=-=%@",error);
        
        [weakSelf endRefreshing];
        [weakSelf.view hideLoading];
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
