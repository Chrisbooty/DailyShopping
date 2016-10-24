//
//  CJTool.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/22.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJTool.h"
#import <MBProgressHUD.h>

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
#pragma mark -计算商品数量
+ (NSString *)treatProductCount:(NSInteger)cnt
{
    if (cnt < 10000) return [NSString stringWithFormat:@"%ld",cnt];
    return [CJTool changeFloat:[NSString stringWithFormat:@"%ld",cnt /1000 * 10]];
}
#pragma mark -显示加载中
+ (void)showMsg:(NSString *)msg withController:(UIViewController *)controller
{
    //    NSLog(@"%@,%s",msg,__func__);
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:controller.view];
    [hud hideAnimated:YES];
    [hud removeFromSuperViewOnHide];
    if (msg.length > 0) {
        
        hud.mode = MBProgressHUDModeText;
        hud.label.text = msg;
        [controller.view addSubview:hud];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperViewOnHide];
        });
    }
}
#pragma mark - 设置Tabbar
+ (void)setTabbarWithController:(UIViewController *)controller withImageName:(NSString *)imageName withTitle:(NSString *)title
{
    //自定义tabbar
    controller.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@-hl",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.title = title;
    controller.tabBarController.tabBar.tintColor = [UIColor colorWithRed: 252/255.0 green: 44/255.0 blue: 71 /255.0 alpha:1];
}
@end