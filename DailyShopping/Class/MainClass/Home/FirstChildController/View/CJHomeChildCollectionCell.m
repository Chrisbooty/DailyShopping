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
    
    [CJTool setImageViewWithYYImageKit:_goodsImageView withURL:model.thumb_url];
    _goodstitleLabel.text = model.goods_name;
    
    if (model.time.length > 0) {
        NSString * tempStr;
        NSInteger time = [CJTool intervalFromLastDate:model.time].integerValue;
        if (time > 59) {
            tempStr = @"%ld人团·%ld小时前";
            time = time / 60;
        }else
        {
            tempStr = @"%ld人团·%ld分钟前";
        }
        _goodsGroupLabel.text = [NSString stringWithFormat:tempStr,model.customer_num,time];
    }else
    {
        _goodsGroupLabel.text = [NSString stringWithFormat:@"%ld人团·已团%@万件",model.customer_num,[CJTool treatProductCount:model.cnt]];
    }
    
    _goodsPriceLabel.text = [NSString stringWithFormat:@"¥%@",[CJTool changePrice:[NSString stringWithFormat:@"%ld",model.price]]];
}

@end
