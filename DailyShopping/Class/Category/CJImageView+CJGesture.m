//
//  UIImageView+CJGesture.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/21.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJImageView+CJGesture.h"

@implementation CJImageView (CJGesture)

- (void)cj_addTapGestureWithSelector:(SEL)selector withImageURL:(NSURL *)imgURL andAnswer:(id)answer
{
    self.userInteractionEnabled = YES;
    [self sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"photo"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:answer action:selector];
    [self addGestureRecognizer:tap];
    
}

@end
