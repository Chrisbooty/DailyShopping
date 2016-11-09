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
+ (NSString *)changePrice:(NSString *)string;
/**
 计算商品数量

 @param cnt 数量
 */
+ (NSString *)treatProductCount:(NSInteger)cnt;
/**
 数据请求动画

 @param msg        显示的文本
 @param controller 控制器
 */
+ (void)showMsg:(NSString *)msg withController:(UIViewController *)controller;
/**
 设置Tabbar

 @param controller 控制器
 @param imageName  图标名
 @param title      显示文字
 */
+ (void)setTabbarWithController:(UIViewController *)controller withImageName:(NSString *)imageName withTitle:(NSString *)title;

/**
 计算时间差

 @param dateString2 时间(单位：秒)
 */
+ (NSString *)intervalFromLastDate: (NSString *) dateString2;
/**
 网路请求设置image
 */
+ (void)setImageViewWithYYImageKit:(UIImageView *)imageView withURL:(NSURL *)url;

@end
