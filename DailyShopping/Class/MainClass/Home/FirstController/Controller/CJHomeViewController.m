//
//  CJHomeViewController.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeViewController.h"
#import "CJLabel.h"
#import "CJHomeChildTableViewController.h"
#import "CJHomeChildCollectionViewController.h"

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
    
//    _controllerScrollView.contentSize = CGSizeMake(CWidth +20, 0);
    
    [self setUpChildController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIViewController *VC = self.childViewControllers.lastObject;
    VC.view.frame = _controllerScrollView.bounds;
    
}

#pragma mark -添加子控制器
- (void)setUpChildController
{
    //首页控制器
    CJHomeChildTableViewController *homeChildTableVC = [[CJHomeChildTableViewController alloc] initWithNibName:@"CJHomeChildTableViewController" bundle:nil];
    
    [self addChildViewController:homeChildTableVC];
    
    
    
    [_controllerScrollView addSubview:homeChildTableVC.view];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
