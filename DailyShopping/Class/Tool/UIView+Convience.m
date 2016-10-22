//
//  UIView+Convience.m
//  FixJob
//
//  Created by terry_ash on 1/12/16.
//  Copyright © 2016 terry_ash. All rights reserved.
//

#import "UIView+Convience.h"
#import <MBProgressHUD.h>

#define kAshViewConenceHudTag 93929L

@implementation UIView (Convience)
+ (void)showMsg:(NSString *)msg{
    
    [self showMsg:msg];
}

- (void)showMsg:(NSString *)msg{
//    NSLog(@"%@,%s",msg,__func__);
    [self hideLoading];
    if (msg.length > 0) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = msg;
        [self addSubview:hud];
        [hud showAnimated:NO whileExecutingBlock:^{
            [NSThread sleepForTimeInterval:1];
        } completionBlock:^{
            [hud removeFromSuperViewOnHide];
        }];
    }
}

+ (void)showMsg:(NSString *)msg andBlocl:(void(^)(void))block{
    
    [self showMsg:msg];
}
- (void)showMsg:(NSString *)msg andBlocl:(void(^)(void))block{
    NSLog(@"%@,%s",msg,__func__);
    [self hideLoading];
    if (msg.length > 0) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = msg;
        [self addSubview:hud];
        [hud showAnimated:NO whileExecutingBlock:^{
            [NSThread sleepForTimeInterval:0.7];
        } completionBlock:^{
            block();
            [hud removeFromSuperViewOnHide];
        }];
    }
}

- (void)showLoading{
    MBProgressHUD *hud = [self viewWithTag:kAshViewConenceHudTag];
    if (nil == hud) {
        hud = [[MBProgressHUD alloc] initWithView:self];
        hud.tag = kAshViewConenceHudTag;
        hud.labelText = @"加载中";
        [self addSubview:hud];
    }
    [hud show:YES];
}
#pragma mark -加载中的动画
- (void)showLoading:(NSString *)str{
    MBProgressHUD *hud = [self viewWithTag:kAshViewConenceHudTag];
    if (nil == hud) {
        hud = [[MBProgressHUD alloc] initWithView:self];
        hud.tag = kAshViewConenceHudTag;
        hud.labelText = str;
        [self addSubview:hud];
    }
    [hud show:YES];
}

- (void)showErr:(NSError *)err{
    if ([err.localizedDescription length] > 0) {
         [self showMsg:err.localizedDescription];
    }
}

- (void)hideLoading{
    MBProgressHUD *hud = [self viewWithTag:kAshViewConenceHudTag];
    [hud hide:YES];
    [hud removeFromSuperViewOnHide];
}

- (void)fj_showErrorMsg:(NSError *)error{
    NSString *msg =  error.localizedDescription;
    [self showMsg:msg];
}

@end
