//
//  CJRecommandTableCell.m
//  DailyShopping
//
//  Created by Cijian on 2016/11/9.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJRecommandTableCell.h"
#import "CJRecommandCollectionCell.h"

@interface CJRecommandTableCell ()

/**
 描述 - UILabel
 */
@property (weak, nonatomic) IBOutlet UILabel *subjectL;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation CJRecommandTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CJRecommandCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"CJRecommandCollectionCell"];
}

- (IBAction)viewMoreClick {
    
}

- (void)setModel:(CJRecommandGroupModel *)model
{
    _model = model;
    _subjectL.text = model.subject;
    dispatch_async(dispatch_get_main_queue(), ^{
        _collectionView.contentOffset = CGPointZero;
        [_collectionView reloadData];
    });
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
    return _model.recommandGoodModels.count;
}
#pragma mark -CollectionView --设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CJRecommandCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CJRecommandCollectionCell" forIndexPath:indexPath];
    cell.model = _model.recommandGoodModels[indexPath.row];
    return cell;
}

@end
