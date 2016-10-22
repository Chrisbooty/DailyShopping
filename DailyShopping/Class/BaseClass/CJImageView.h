//
//  CJImageView.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJImageView : UIImageView

/** 图片跳转URL */
@property (nonatomic, copy) NSString *URL;
/** 标题 - 跳转控制器title*/
@property (nonatomic, copy) NSString *subject;
/** 跳转id */
@property (nonatomic, assign) NSInteger subject_id;

@end
