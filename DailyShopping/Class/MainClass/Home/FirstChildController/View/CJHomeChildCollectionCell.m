//
//  CJHomeChildCollectionCell.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeChildCollectionCell.h"
#import <UIImageView+WebCache.h>
#import "CJTool.h"

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

- (void)setModel:(CJHomeCollectionModel *)model
{
    _model = model;
    
    [_goodsImageView sd_setImageWithURL:model.thumb_url placeholderImage:[UIImage imageNamed:@"photo"]];
    _goodstitleLabel.text = model.goods_name;
    
    _goodsGroupLabel.text = [NSString stringWithFormat:@"%ld人团·已团%ld万件",model.customer_num,model.cnt];
    _goodsPriceLabel.text = [NSString stringWithFormat:@"%ld",model.price];
}

@end
