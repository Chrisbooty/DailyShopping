//
//  CJHomeChildTableViewCell.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/22.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeChildTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "CJTool.h"

@interface CJHomeChildTableViewCell ()
/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
/**
 商品描述
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsDescriptionLabel;
/**
 团购限定人数
 */
@property (weak, nonatomic) IBOutlet UIButton *goodsGroupCntBtn;
/**
 团购价格
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsGruopPriceLabel;
/**
 单买价格
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsSinglePriceLabel;
/**
 开团按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *goodsGroupBuyBtn;


@end

@implementation CJHomeChildTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //按钮圆角
    _goodsGroupBuyBtn.layer.cornerRadius = 5;
}


- (void)setModel:(CJHomeChildTableCellModel *)model
{
    _model = model;
//    [self performSelectorOnMainThread:@selector(loadImageForCell) withObject:nil waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
    [self loadImageForCell];
    _goodsDescriptionLabel.text = model.goods_name;
    [_goodsGroupCntBtn setTitle:[NSString stringWithFormat:@"%@人团",model.customer_num] forState:UIControlStateNormal];
    _goodsGruopPriceLabel.text = [CJTool changeFloat:model.price];
    [CJTool setRichTextWithLabel:_goodsSinglePriceLabel withText:[NSString stringWithFormat:@"单买价 %@",[CJTool changeFloat:model.normal_price]]];
}


- (void)loadImageForCell
{
    [_goodsImageView sd_setImageWithURL:_model.image_url placeholderImage:[UIImage imageNamed:@"photo"]];
}

#pragma mark -点击开团按钮
- (IBAction)GroupBuyBtnClick:(UIButton *)sender {
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
