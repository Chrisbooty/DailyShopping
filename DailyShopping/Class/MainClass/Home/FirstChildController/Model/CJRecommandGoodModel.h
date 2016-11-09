//
//  CJRecommandGoodModel.h
//  DailyShopping
//
//  Created by Cijian on 2016/11/9.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJRecommandGoodModel : NSObject

/**
 价格
 */
@property (nonatomic, copy) NSString *price;
/**
 图片URL
 */
@property (nonatomic, strong) NSURL *thumb_url;
/**
 商品id
 */
@property (nonatomic, assign) NSInteger goods_id;
/**
 商品名称
 */
@property (nonatomic, copy) NSString *goods_name;


@end
