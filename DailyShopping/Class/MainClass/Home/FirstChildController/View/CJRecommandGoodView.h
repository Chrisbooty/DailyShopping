//
//  CJRecommandGoodView.h
//  DailyShopping
//
//  Created by Cijian on 2016/11/9.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJRecommandGoodModel.h"

@interface CJRecommandGoodView : UIView

/**
 model - CJRecommandGoodModel
 */
@property (nonatomic, strong) CJRecommandGoodModel *model;

/**
 从xib创建view
 */
+ (instancetype)view;

@end
