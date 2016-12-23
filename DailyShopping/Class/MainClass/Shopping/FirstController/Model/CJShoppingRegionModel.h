//
//  CJShopBannerModel.h
//  DailyShopping
//
//  Created by Cijian on 2016/11/9.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJShoppingRegionModel : NSObject

/**
 banner 图片
 */
@property (nonatomic, copy) NSString *home_banner;
/**
 banner 名
 */
@property (nonatomic, copy) NSString *subject;
/**
 跳转id
 */
@property (nonatomic, assign) NSInteger subject_id;


@end
