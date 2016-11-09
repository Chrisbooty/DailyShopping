//
//  CJHomeCollectionModel.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface CJHomeCollectionModel : NSObject

/** 商品描述 */
@property (nonatomic, copy) NSString *goods_name;
/** 商品图片URL */
@property (nonatomic, strong) NSURL *thumb_url;
/** 商品价格 - group - price 1800 = 18.00 */
@property (nonatomic, assign) NSInteger price;
/** 团购人数 - group - customer_num*/
@property (nonatomic, assign) NSInteger customer_num;
/** 已经团购商品数量 1800 = 1800件 | 180000 = 18.0万件 */
@property (nonatomic, assign) NSInteger cnt;
/** 市场价 */
@property (nonatomic, assign) NSInteger market_price;
/**
 时间 - 秒
 */
@property (nonatomic, copy) NSString *time;

@end
