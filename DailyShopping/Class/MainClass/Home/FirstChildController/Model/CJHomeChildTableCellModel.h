//
//  CJHomeChildTableCellModel.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/22.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface CJHomeChildTableCellModel : NSObject

/** 
 图片URL 
 */
@property (nonatomic, strong) NSURL *image_url;
/**
 商品名称
 */
@property (nonatomic, copy) NSString *goods_name;
/**
 开团人数 group - customer_num
 */
@property (nonatomic, copy) NSString *customer_num;
/**
 团购价格 group - price
 */
@property (nonatomic, copy) NSString *price;
/**
 单买价格
 */
@property (nonatomic, copy) NSString *normal_price;
/**
 商品id
 */
@property (nonatomic, copy) NSString *goods_id;


@end
