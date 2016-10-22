//
//  CJHeader.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//





#ifndef CJHeader_h
#define CJHeader_h

//屏幕宽
#define CWidth [UIScreen mainScreen].bounds.size.width
//屏幕宽
#define CHeight [UIScreen mainScreen].bounds.size.height

// RGB颜色
#define CJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 弱引用
#define CJWeakSelf __weak typeof(self) weakSelf = self;



//首页轮播图 - 限时秒杀
#define limitTimeBtnTag 10001
//首页轮播图 - 超值大牌
#define superBtnTag 10002
//首页轮播图 - 品质水果团
#define fruitBtnTag 10003
//首页轮播图 - 海淘
#define shoppingBtnTag 10004
//首页轮播图 - 9块9特卖
#define preferentialBtnTag 10005
//首页轮播图 - 免费试用团
#define trialBtnTag 10006
//首页轮播图 - 特惠量贩
#define limitCountBtnTag 10007
//首页轮播图 - 爱轻奢
#define luxuryBtnTag 10008


#endif /* CJHeader_h */
