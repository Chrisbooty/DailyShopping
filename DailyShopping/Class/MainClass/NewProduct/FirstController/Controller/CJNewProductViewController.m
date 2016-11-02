//
//  CJNewProductViewController.m
//  DailyShopping
//
//  Created by Cijian on 2016/11/2.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJNewProductViewController.h"
#import "CJNewCollectionHeaderView.h"


@interface CJNewProductViewController ()

@end

@implementation CJNewProductViewController

////collectionView 列数
//static CGFloat const column = 2;
//headerView 重用ID
static NSString * const headerID = @"CJNewCollectionHeaderView";

- (void)awakeFromNib
{
    [super awakeFromNib];
    //设置Tabbar
    [CJTool setTabbarWithController:self withImageName:@"rank" withTitle:@"上新"];
    
    self.URL = CJNewProductURL;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page = 1;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView registerNib:[UINib nibWithNibName:headerID bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(64, 0,49, 0);
    self.flowLayout.headerReferenceSize = CGSizeMake(CWidth, 150);
}

#pragma mark -重写网络字段
- (void)setCollectionRefresh
{
    //设置上下拉刷新
    [self.collectionView setCollectionViewRefreshWithController:self isPage:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CJNewCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        
        return headerView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
