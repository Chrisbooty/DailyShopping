//
//  CJShoppingClassifyCell.m
//  DailyShopping
//
//  Created by Cijian on 2016/12/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJShoppingClassifyCell.h"

@interface CJShoppingClassifyCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation CJShoppingClassifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imgV.layer.cornerRadius = 5;
}

@end
