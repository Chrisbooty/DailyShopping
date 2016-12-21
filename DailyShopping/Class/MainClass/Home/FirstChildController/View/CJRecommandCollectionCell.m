//
//  CJRecommandCollectionCell.m
//  DailyShopping
//
//  Created by Cijian on 2016/12/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJRecommandCollectionCell.h"

@interface CJRecommandCollectionCell ()

/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
/**
 商品名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameL;
/**
 商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@end

@implementation CJRecommandCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CJRecommandGoodModel *)model
{
    _model = model;
    [CJTool setImageViewWithYYImageKit:_imgV withURL:model.thumb_url];
    _nameL.text = model.goods_name;
    _priceL.text = [NSString stringWithFormat:@"￥%@",model.price];
}

@end
