//
//  CJHomeChildTableBannerModel.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJHomeChildTableBannerModel : NSObject

/** banner图片路径 */
@property (nonatomic, strong) NSURL *home_banner_2;
/** 标题 - 跳转控制器title*/
@property (nonatomic, copy) NSString *subject;
/** 跳转id */
@property (nonatomic, assign) NSInteger subject_id;

@end
