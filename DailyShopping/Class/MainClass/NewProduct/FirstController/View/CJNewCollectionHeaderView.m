//
//  CJNewProductHeaderView.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/24.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJNewCollectionHeaderView.h"
#import <UIImageView+WebCache.h>
#import "LXNetworking.h"

@interface CJNewCollectionHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *cityOneImgV;
@property (weak, nonatomic) IBOutlet UIImageView *cityTwoImgV;
@property (weak, nonatomic) IBOutlet UIImageView *perfecOnetImgV;
@property (weak, nonatomic) IBOutlet UIImageView *perfectTwoImgV;

@property (weak, nonatomic) IBOutlet UIImageView *leftBgImgV;
@property (weak, nonatomic) IBOutlet UIImageView *rightBgImgV;

@end

@implementation CJNewCollectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setHeaderImg];
    
    _cityTwoImgV.layer.cornerRadius = 10;
    _cityTwoImgV.layer.cornerRadius = 10;
    _perfecOnetImgV.layer.cornerRadius = 10;
    _perfectTwoImgV.layer.cornerRadius = 10;
    _leftBgImgV.layer.cornerRadius = 10;
    _rightBgImgV.layer.cornerRadius = 10;
}


- (void)setHeaderImg
{
    [LXNetworking getWithUrl:JCNewProductAvatarURL params:nil success:^(id response) {
        
        NSArray *arr = response[@"goods_list"];
        [_cityOneImgV sd_setImageWithURL:[NSURL URLWithString:arr.firstObject[@"thumb_url"]] placeholderImage:[UIImage imageNamed:@"photo"]];
        [_cityTwoImgV sd_setImageWithURL:[NSURL URLWithString:arr.lastObject[@"thumb_url"]] placeholderImage:[UIImage imageNamed:@"photo"]];
        [_perfecOnetImgV sd_setImageWithURL:[NSURL URLWithString:[response[@"avatars"] firstObject]] placeholderImage:[UIImage imageNamed:@"photo"]];
        [_perfectTwoImgV sd_setImageWithURL:[NSURL URLWithString:[response[@"avatars"] lastObject]] placeholderImage:[UIImage imageNamed:@"photo"]];
        
    } fail:^(NSError *error) {
        NSLog(@"CJNewCollectionHeaderView -- error %@",error);
    } showHUD:nil andController:nil];
}

@end
