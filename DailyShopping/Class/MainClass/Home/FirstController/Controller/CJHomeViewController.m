//
//  CJHomeViewController.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeViewController.h"
#import "CJLabel.h"
#import "CJHomeChildViewController.h"

@interface CJHomeViewController ()
/**
 标题scrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
/**
 自控制器ScrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *controllerScrollView;

@end

@implementation CJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -添加子控制器
- (void)setUpChildController
{
    //
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
