//
//  CJTool.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/22.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJTool : NSObject

/**
 获取单例对象
 */
+ (instancetype)shareTool;

/**
 设置label删除线

 @param label label对象
 @param str   文本信息
 */
+ (void)setRichTextWithLabel:(UILabel *)label withText:(NSString *)str;
/**
 去掉价格或者其他数字小数点后面多余的0
 
 @param string 转化前价格
 @return 转化后价格
 */
+ (NSString *)changeFloat:(NSString *)string;
/**
 计算商品数量

 @param cnt 数量
 */
+ (NSString *)treatProductCount:(NSInteger)cnt;

@end
