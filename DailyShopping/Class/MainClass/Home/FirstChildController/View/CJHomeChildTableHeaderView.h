//
//  CJHomeChildTableHeaderView.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJHomeChildTableBannerModel.h"
#import "CJHeader.h"

@interface CJHomeChildTableHeaderView : UIView

/** model - CJHomeChildTableBannerModel */
@property (nonatomic, strong) NSArray<CJHomeChildTableBannerModel *> *bannerModelArr;
@property (weak, nonatomic) IBOutlet UIView *classView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ClassViewHeightLayout;

@end
