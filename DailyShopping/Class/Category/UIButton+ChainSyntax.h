//
//  UIButton+ChainSyntax.h
//  CodeEncapsulation
//
//  Created by skyios on 16/11/2.
//  Copyright © 2016年 skyios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIButton *(^ButtonColorSetting)(UIColor *color);
typedef UIButton *(^ButtonFrameSetting)(CGRect frame);
typedef UIButton *(^ButtonTitleSetting)(NSString *title);
typedef UIButton *(^ButtonImageSetting)(UIImage *image);
typedef UIButton *(^ButtonFontSetting)(UIFont *font);

@interface UIButton (ChainSyntax)
/// 系统初始化
+(instancetype)custom;
+(instancetype)round;


-(ButtonTitleSetting)normalTitle;
-(ButtonTitleSetting)selectedTitle;
-(ButtonTitleSetting)highlightedTitle;

-(ButtonImageSetting)normalImage;
-(ButtonImageSetting)selectedImage;
-(ButtonImageSetting)highlightedImage;

-(ButtonImageSetting)normalBackgroundImage;
-(ButtonImageSetting)selectedBackgroundImage;
-(ButtonImageSetting)highlightedBackgroundImage;

-(ButtonColorSetting)normalTitleColor;
-(ButtonColorSetting)selectedTitleColor;
-(ButtonColorSetting)highlightedTitleColor;
-(ButtonColorSetting)normalTitleShadowColor;
-(ButtonColorSetting)selectedTitleShadowColor;
-(ButtonColorSetting)highlightedTitleShadowColor;

-(ButtonFontSetting)titleFont;

-(ButtonFrameSetting)buttonFrame;
@end
