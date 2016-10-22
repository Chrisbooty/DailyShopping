//
//  CJTool.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/22.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJTool.h"

@implementation CJTool

static CJTool *tool;

+ (instancetype)shareTool
{
    if (tool == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tool = [CJTool new];
        });
    }
    return tool;
}
#pragma mark -设置label删除线
+ (void)setRichTextWithLabel:(UILabel *)label withText:(NSString *)str
{
    //    NSAttributedString *attrStr =
    //    [[NSAttributedString alloc]initWithString:str
    //                                  attributes:
    //字体大小
    //  @{NSFontAttributeName:[UIFont systemFontOfSize:20.f],
    //颜色
    //    NSForegroundColorAttributeName:[UIColor lightGrayColor],
    //    NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
    //    NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    
    NSAttributedString *attrStr =
    [[NSAttributedString alloc]initWithString:str
                                   attributes:
     @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    
    label.attributedText = attrStr;
}

#pragma mark -去掉价格或者其他数字小数点后面多余的0
+(NSString *)changeFloat:(NSString *)string
{
    NSMutableString *stringFloat = [NSMutableString stringWithString:string];
    [stringFloat insertString:@"." atIndex:string.length - 2];
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSUInteger i = length-1;
    for(; i >= 0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}
@end
