//
//  UIButton+ChainSyntax.m
//  CodeEncapsulation
//
//  Created by skyios on 16/11/2.
//  Copyright © 2016年 skyios. All rights reserved.
//

#import "UIButton+ChainSyntax.h"

@implementation UIButton (ChainSyntax)
+(instancetype)round {
    return [self buttonWithType:UIButtonTypeRoundedRect];
}
+(instancetype)custom {
    return [self buttonWithType:UIButtonTypeCustom];
}


-(ButtonTitleSetting)normalTitle {
    return ^UIButton *(NSString *title) {
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}
-(ButtonTitleSetting)selectedTitle{
    return ^UIButton *(NSString *title) {
        [self setTitle:title forState:UIControlStateSelected];
        return self;
    };
}
-(ButtonTitleSetting)highlightedTitle {
    return ^UIButton *(NSString *title) {
        [self setTitle:title forState:UIControlStateHighlighted];
        return self;
    };
}

-(ButtonImageSetting)normalImage {
    return ^UIButton *(UIImage *image) {
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}
-(ButtonImageSetting)selectedImage {
    return ^UIButton *(UIImage *image) {
        [self setImage:image forState:UIControlStateSelected];
        return self;
    };
}
-(ButtonImageSetting)highlightedImage {
    return ^UIButton *(UIImage *image) {
        [self setImage:image forState:UIControlStateHighlighted];
        return self;
    };
}
-(ButtonImageSetting)normalBackgroundImage {
    return ^UIButton *(UIImage *image) {
        [self setBackgroundImage:image forState:UIControlStateNormal];
        return self;
    };
}
-(ButtonImageSetting)selectedBackgroundImage {
    return ^UIButton *(UIImage *image) {
        [self setBackgroundImage:image forState:UIControlStateSelected];
        return self;
    };
}
-(ButtonImageSetting)highlightedBackgroundImage {
    return ^UIButton *(UIImage *image) {
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
        return self;
    };
}
-(ButtonColorSetting)normalTitleColor {
    return ^UIButton *(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}
-(ButtonColorSetting)selectedTitleColor {
    return ^UIButton *(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateSelected];
        return self;
    };
}
-(ButtonColorSetting)highlightedTitleColor {
    return ^UIButton *(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateHighlighted];
        return self;
    };
}
-(ButtonColorSetting)normalTitleShadowColor {
    return ^UIButton *(UIColor *color) {
        [self setTitleShadowColor:color forState:UIControlStateNormal];
        return self;
    };
}
-(ButtonColorSetting)selectedTitleShadowColor {
    return ^UIButton *(UIColor *color) {
        [self setTitleShadowColor:color forState:UIControlStateSelected];
        return self;
    };
}
-(ButtonColorSetting)highlightedTitleShadowColor{
    return ^UIButton *(UIColor *color) {
        [self setTitleShadowColor:color forState:UIControlStateHighlighted];
        return self;
    };
}
-(ButtonFontSetting)titleFont {
    return ^UIButton *(UIFont *font) {
        self.titleLabel.font = font;
        return self;
    };
}

-(ButtonFrameSetting)buttonFrame {
    return ^ UIButton *(CGRect frame) {
        self.frame = frame;
        return self;
    };
}

@end
