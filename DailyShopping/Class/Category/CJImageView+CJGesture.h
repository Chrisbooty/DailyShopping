//
//  UIImageView+CJGesture.h
//  DailyShopping
//
//  Created by Cijian on 2016/10/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJImageView.h"
#import <UIImageView+WebCache.h>

@interface CJImageView (CJGesture)

- (void)cj_addTapGestureWithSelector:(SEL)selector withImageURL:(NSURL *)imgURL andAnswer:(id)answer;
@end
