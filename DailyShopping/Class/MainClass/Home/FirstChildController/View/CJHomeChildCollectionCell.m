//
//  CJHomeChildCollectionCell.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeChildCollectionCell.h"

@interface CJHomeChildCollectionCell ()

/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

/**
 商品描述
 */
@property (weak, nonatomic) IBOutlet UILabel *goodstitleLabel;

/**
 商品价格 - ￥3.50
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

/**
 团购人数- 2人团·已团6.0万件
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsGroupLabel;



@end

@implementation CJHomeChildCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
