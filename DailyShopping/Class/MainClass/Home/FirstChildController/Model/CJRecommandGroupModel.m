//
//  CJRecommandModel.m
//  DailyShopping
//
//  Created by Cijian on 2016/11/9.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJRecommandGroupModel.h"
#import <YYModel/YYModel.h>


@implementation CJRecommandGroupModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"recommandGoodModels":@"goods_list"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"recommandGoodModels":[CJRecommandGoodModel class]
             };
}


@end
