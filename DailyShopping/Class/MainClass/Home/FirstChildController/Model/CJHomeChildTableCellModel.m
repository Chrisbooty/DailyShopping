//
//  CJHomeChildTableCellModel.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/22.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeChildTableCellModel.h"
#import <YYModel/YYModel.h>

@implementation CJHomeChildTableCellModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"customer_num": @"group.customer_num",@"price": @"group.price"};
}


@end
