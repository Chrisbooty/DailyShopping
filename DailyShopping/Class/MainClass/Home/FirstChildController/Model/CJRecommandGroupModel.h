//
//  CJRecommandModel.h
//  DailyShopping
//
//  Created by Cijian on 2016/11/9.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJRecommandGoodModel.h"

@interface CJRecommandGroupModel : NSObject

/**
 cell所在位置 - NSInteger
 */
@property (nonatomic, assign) NSInteger position;
/**
 查看更多id
 */
@property (nonatomic, assign) NSInteger subject_id;
/**
 推荐信息名
 */
@property (nonatomic, copy) NSString *subject;
/**
 商品列表
 */
@property (nonatomic, strong) NSArray *recommandGoodModels;


@end
