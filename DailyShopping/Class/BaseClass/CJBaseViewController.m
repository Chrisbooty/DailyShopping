//
//  CJBaseViewController.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJBaseViewController.h"
#import "CJNetworking.h"

#import <MBProgressHUD.h>

@interface CJBaseViewController ()

@end

@implementation CJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)getDefaultPage
{
    _page = 1;
}

- (void)requestCellData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
