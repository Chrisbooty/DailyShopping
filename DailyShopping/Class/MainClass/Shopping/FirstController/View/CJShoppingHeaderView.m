//
//  CJShoppingHeaderView.m
//  DailyShopping
//
//  Created by Cijian on 2016/12/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJShoppingHeaderView.h"
#import "CJShoppingRegionCell.h"
#import "CJShoppingClassifyCell.h"

@interface CJShoppingHeaderView ()

@property (weak, nonatomic) IBOutlet UICollectionView *regionCollection;

@property (weak, nonatomic) IBOutlet UICollectionView *classifyCollection;

@end

@implementation CJShoppingHeaderView

static NSString * const regionId = @"CJShoppingRegionCell";
static NSString * const classifyId = @"CJShoppingClassifyCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [_regionCollection registerNib:[UINib nibWithNibName:regionId bundle:nil] forCellWithReuseIdentifier:regionId];
    [_classifyCollection registerNib:[UINib nibWithNibName:classifyId bundle:nil] forCellWithReuseIdentifier:classifyId];
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
        return 5;
    }
    return 4;
}
#pragma mark -CollectionView --设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _regionCollection) {
        CJShoppingRegionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:regionId forIndexPath:indexPath];
        return cell;
    }else {
        CJShoppingClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:classifyId forIndexPath:indexPath];
        return cell;
    }
}
#pragma mark - subviews
- (IBAction)viewMoreBtnClick {
    
}


@end
