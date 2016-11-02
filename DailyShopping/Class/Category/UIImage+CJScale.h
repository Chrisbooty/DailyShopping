//
//  UIImage+CJScale.h
//  DailyShopping
//
//  Created by Cijian on 2016/11/2.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CJScale)

/**
 缩放图片

 @param image 图片
 @param newSize 新图片的大小
 @param offSet 缩小的尺寸
 @return 新的图片
 */
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize andOffSet:(CGPoint)offSet;

@end
