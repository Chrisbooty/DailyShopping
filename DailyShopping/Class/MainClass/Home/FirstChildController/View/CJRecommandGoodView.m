//
//  CJRecommandGoodView.m
//  DailyShopping
//
//  Created by Cijian on 2016/11/9.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJRecommandGoodView.h"
#import "CJTool.h"

@interface CJRecommandGoodView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@end

@implementation CJRecommandGoodView

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CJRecommandGoodView" owner:nil options:nil] firstObject];
}

- (void)setModel:(CJRecommandGoodModel *)model
{
    _model = model;
    [CJTool setImageViewWithYYImageKit:_imgView withURL:model.thumb_url];
    _descriptionL.text = model.goods_name;
    _priceL.text = [NSString stringWithFormat:@"￥%@",[CJTool changePrice:model.price]];
}

@end
