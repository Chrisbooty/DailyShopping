//
//  CJShoppingHeaderView.m
//  DailyShopping
//
//  Created by Cijian on 2016/12/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJShoppingHeaderView.h"

@interface CJShoppingHeaderView ()

@property (weak, nonatomic) IBOutlet UICollectionView *regionCollection;

@property (weak, nonatomic) IBOutlet UICollectionView *classifyCollection;

/**
 region数据源
 */
@property (nonatomic, strong) NSMutableArray *regionArrM;
/**
 classify数据源
 */
@property (nonatomic, strong) NSMutableArray *classifyArrM;

@end

@implementation CJShoppingHeaderView

static NSString * const regionId = @"CJShoppingRegionCell";
static NSString * const classifyId = @"CJShoppingClassifyCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [_regionCollection registerNib:[UINib nibWithNibName:regionId bundle:nil] forCellWithReuseIdentifier:regionId];
    [_classifyCollection registerNib:[UINib nibWithNibName:classifyId bundle:nil] forCellWithReuseIdentifier:classifyId];
    
    [self loadData];
}

+ (instancetype)view
{
    return [[NSBundle mainBundle] loadNibNamed:@"CJShoppingHeaderView" owner:nil options:nil].firstObject;
}

- (void)loadData
{
    //地域region数据
    NSArray *regionNameArr = @[@"日本馆",@"韩国馆",@"澳洲馆",@"欧美馆",@"东南亚馆"];
    NSArray *regionImgArr = @[@"japan",@"korea",@"australia",@"american",@"southeast_asia"];
    NSArray *regionIdArr = @[@"287",@"94",@"64",@"286",@"65"];
    for (NSInteger i = 0; i < regionIdArr.count; i++) {
        CJShoppingRegionModel *model = [CJShoppingRegionModel new];
        model.home_banner = regionImgArr[i];
        model.subject = regionNameArr[i];
        model.subject_id = [regionIdArr[i] integerValue];
        [self.regionArrM addObject:model];
    }
    //分类classify数据
    NSArray *classifyImgArr = @[@"food",@"skin_care",@"health",@"makeup"];
    NSArray *classifyIdArr = @[@"219",@"262",@"299",@"264"];
    for (NSInteger i = 0; i < classifyImgArr.count; i++) {
        CJShoppingClassifyModel *model = [CJShoppingClassifyModel new];
        model.imgName = classifyImgArr[i];
        model.subject_id = [classifyIdArr[i] integerValue];
        [self.classifyArrM addObject:model];
    }
}

#pragma mark - CollectionView 代理方法
#pragma mark -CollectionView --段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark -CollectionView --行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _regionCollection) {
        return self.regionArrM.count;
    }
    return self.classifyArrM.count;
}
#pragma mark -CollectionView --设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _regionCollection) {
        CJShoppingRegionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:regionId forIndexPath:indexPath];
        cell.model = _regionArrM[indexPath.row];
        return cell;
    }else {
        CJShoppingClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:classifyId forIndexPath:indexPath];
        cell.model = _classifyArrM[indexPath.row];
        return cell;
    }
}
#pragma mark - subviews
- (IBAction)viewMoreBtnClick {
    
}

#pragma mark -懒加载
- (NSMutableArray *)regionArrM
{
    if (!_regionArrM) {
        _regionArrM = [NSMutableArray array];
    }
    return _regionArrM;
}
- (NSMutableArray *)classifyArrM
{
    if (!_classifyArrM) {
        _classifyArrM = [NSMutableArray array];
    }
    return _classifyArrM;
}
@end
