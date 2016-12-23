//
//  CJShoppingRegionCell.m
//  DailyShopping
//
//  Created by Cijian on 2016/12/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJShoppingRegionCell.h"

@interface CJShoppingRegionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (weak, nonatomic) IBOutlet UILabel *nameL;


@end

@implementation CJShoppingRegionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CJShoppingRegionModel *)model
{
    _model = model;
    _imgV.image = [UIImage imageNamed:model.home_banner];
    _nameL.text = model.subject;
}

@end
