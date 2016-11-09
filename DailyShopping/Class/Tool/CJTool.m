//
//  CJTool.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/22.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJTool.h"
#import "UIImage+CJScale.h"
#import <MBProgressHUD.h>
#import <YYWebImage/YYWebImage.h>

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
+(NSString *)changePrice:(NSString *)string
{
    if (string.length > 2) {
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
    return string;
}
#pragma mark -计算商品数量
+ (NSString *)treatProductCount:(NSInteger)cnt
{
    if (cnt < 10000) return [NSString stringWithFormat:@"%ld",cnt];
    return [CJTool changePrice:[NSString stringWithFormat:@"%ld",cnt /1000 * 10]];
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
    controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    //    controller.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@-hl",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.title = title;
    controller.tabBarController.tabBar.tintColor = [UIColor colorWithRed: 252/255.0 green: 44/255.0 blue: 71 /255.0 alpha:1];
    //    controller.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    controller.tabBarItem.selectedImage = [[UIImage alloc] imageWithImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@-hl",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] scaledToSize:CGSizeMake(20, 20) andOffSet:CGPointMake(0, 0)];
    controller.tabBarItem.image = [[UIImage alloc] imageWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] scaledToSize:CGSizeMake(20, 20) andOffSet:CGPointMake(0, 0)];
}
#pragma mark - 计算时间差
+ (NSString *)intervalFromLastDate: (NSString *) dateString2
{
//    NSArray *timeArray1=[dateString2 componentsSeparatedByString:@"."];
//    dateString2=[timeArray1 objectAtIndex:0];
//    
//    //当前时间
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString *dateString1 = [formatter stringFromDate:[NSDate date]];
//    
//    NSDateFormatter *date=[[NSDateFormatter alloc] init];
//    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSDate *d1=[date dateFromString:dateString1];
//    
//    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
//    
//    NSDate *d2=[date dateFromString:dateString2];
//    
//    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
//    
//    NSTimeInterval cha=late2-late1;
//    NSString *timeString=@"";
//    NSString *house=@"";
//    NSString *min=@"";
//    NSString *sen=@"";
//    
//    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
//    //        min = [min substringToIndex:min.length-7];
//    //    秒
//    sen=[NSString stringWithFormat:@"%@", sen];
//    
//    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
//    //        min = [min substringToIndex:min.length-7];
//    //    分
//    min=[NSString stringWithFormat:@"%@", min];
//    
//    //    小时
//    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
//    //        house = [house substringToIndex:house.length-7];
//    house=[NSString stringWithFormat:@"%@", house];
//    
//    timeString=[NSString stringWithFormat:@"%02d:%02d:%02d",house.intValue,min.intValue,sen.intValue];
//    
//    return timeString;

//    NSArray *timeArray1=[dateString2 componentsSeparatedByString:@"."];
//    dateString2=[timeArray1 objectAtIndex:0];
    
    //当前时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString1 = [formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
//    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2= dateString2.doubleValue;
    
    NSTimeInterval cha = late1 - late2;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    //        min = [min substringToIndex:min.length-7];
    //    秒
    sen=[NSString stringWithFormat:@"%@", sen];
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    
//    timeString=[NSString stringWithFormat:@"%02d:%02d:%02d",house.intValue,min.intValue,sen.intValue];
    
    return min;
    
}
#pragma mark -设置image
+ (void)setImageViewWithYYImageKit:(UIImageView *)imageView withURL:(NSURL *)url
{
    [imageView yy_setImageWithURL:url placeholder:[UIImage imageNamed:@"photo"] options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
}

@end
