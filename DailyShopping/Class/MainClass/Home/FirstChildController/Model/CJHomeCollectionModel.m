//
//  CJHomeCollectionModel.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeCollectionModel.h"


@implementation CJHomeCollectionModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"customer_num":@"group.customer_num",@"price":@"group.price"};
}

@end
