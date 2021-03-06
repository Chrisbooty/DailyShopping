//
//  CJURL.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#ifndef CJURL_h
#define CJURL_h

#define CJBaseHost @"http://api-static.yangkeduo.com"

#define CJDataHost @"http://apiv2.yangkeduo.com"

/*********************************首页*********************************/
//首页轮播图URL
#define CJHomeCarouselURL CJBaseHost@"/subjects"
//推荐cell - size page
#define CJHomeRecommandCellURL CJDataHost@"/v2/goods?size=50&page=%ld"

/** 首页多控制器URL */
    //服饰箱包 - size offset
    #define CJHomeChildClothesURL CJBaseHost@"/operation/14/groups?opt_type=1&size=50&offset=%ld"
    //食品 - size offset
    #define CJHomeChildFoodURL CJBaseHost@"/operation/1/groups?opt_type=1&size=50&offset=%ld"
    //家居生活 - size offset
    #define CJHomeChildLifeURL CJBaseHost@"/operation/15/groups?opt_type=1&size=50&offset=%ld"
    //数码电器 - size offset
    #define CJHomeChildDigitalURL CJBaseHost@"/operation/18/groups?opt_type=1&size=50&offset=%ld"
    //美妆护肤 - size offset
    #define CJHomeChildBeautyURL CJBaseHost@"/operation/16/groups?opt_type=1&size=50&offset=%ld"
    //家纺家居 - size offset
    #define CJHomeChildSpinURL CJBaseHost@"/operation/818/groups?opt_type=1&size=50&offset=%ld"
    //水果生鲜 - size offset
    #define CJHomeChildFruitURL CJBaseHost@"/operation/13/groups?opt_type=1&size=50&offset=%ld"
    //母婴 - size offset
    #define CJHomeChildBabyURL CJBaseHost@"/operation/4/groups?opt_type=1&size=50&offset=%ld"

/*********************************上新*********************************/
    //cell数据
    #define CJNewProductURL CJDataHost@"/v3/newlist?size=50&page=%ld"
    //表头icon
    #define JCNewProductAvatarURL CJDataHost@"/avatars_subjects"

/*********************************海淘*********************************/

#define CJShopping CJBaseHost@"/v2/haitaov2?size=50&page=%ld"




#endif /* CJURL_h */
