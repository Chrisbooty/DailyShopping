//
//  UIImage+CJScale.m
//  DailyShopping
//
//  Created by Cijian on 2016/11/2.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "UIImage+CJScale.h"

@implementation UIImage (CJScale)

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize andOffSet:(CGPoint)offSet
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(offSet.x, offSet.y, newSize.width-offSet.x, newSize.height-offSet.y)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
