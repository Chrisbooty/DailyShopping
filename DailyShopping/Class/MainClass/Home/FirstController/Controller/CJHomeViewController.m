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

@interface CJHomeViewController ()<UIScrollViewDelegate>
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

static NSInteger const childVCNum = 9;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _controllerScrollView.contentSize = CGSizeMake(CWidth +20, 0);
    
    
    
    [self setUpChildController];
    
    [self setupTitle];
    
    [self scrollViewDidEndScrollingAnimation:self.controllerScrollView];
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
    //首页Tbale控制器
    CJHomeChildTableViewController *homeChildTableVC = [[CJHomeChildTableViewController alloc] initWithNibName:@"CJHomeChildTableViewController" bundle:nil];
    homeChildTableVC.title = @"首页";
    [self addChildViewController:homeChildTableVC];
    
    //自控制器标题
    NSArray *titleArr = @[@"服饰箱包",@"食品",@"家居生活",@"数码电器",@"美妆护肤",@"家纺家居",@"水果生鲜",@"母婴"];
    NSArray *URLArr = @[CJHomeChildClothesURL,CJHomeChildFoodURL,CJHomeChildLifeURL,CJHomeChildDigitalURL,CJHomeChildBeautyURL,CJHomeChildSpinURL,CJHomeChildFruitURL,CJHomeChildBabyURL];
    //8个子控制器
    for (NSInteger i = 0; i < childVCNum -1; i++) {
        CJHomeChildCollectionViewController *VC = [CJHomeChildCollectionViewController new];
        VC.title = titleArr[i];
        VC.URL = URLArr[i];
        [self addChildViewController:VC];
    }
}

/**
 * 添加标题
 */
- (void)setupTitle
{
    // 定义临时变量
    CGFloat labelW = 100;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScrollView.frame.size.height;
    
    // 添加label
    for (NSInteger i = 0; i < childVCNum; i++) {
        CJLabel *label = [[CJLabel alloc] init];
        label.text = [self.childViewControllers[i] title];
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [self.titleScrollView addSubview:label];
        
        if (i == 0) { // 最前面的label
            label.scale = 1.0;
        }
    }
    
    // 设置contentSize
    self.titleScrollView.contentSize = CGSizeMake(childVCNum * labelW, 0);
    self.controllerScrollView.contentSize = CGSizeMake(childVCNum * [UIScreen mainScreen].bounds.size.width, 0);
}

/**
 * 监听顶部label点击
 */
- (void)labelClick:(UITapGestureRecognizer *)tap
{
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    
    // 让底部的内容scrollView滚动到对应位置
    CGPoint offset = self.controllerScrollView.contentOffset;
    offset.x = index * self.controllerScrollView.frame.size.width;
    [self.controllerScrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
/**
 * scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    
    // 让对应的顶部标题居中显示
    CJLabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    // 让其他label回到最初的状态
    for (CJLabel *otherLabel in self.titleScrollView.subviews) {
        if (otherLabel != label) otherLabel.scale = 0.0;
    }
    
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    
    // 如果当前位置的位置已经显示过了，就直接返回
    if ([willShowVc isViewLoaded]) return;
    
    // 添加控制器的view到contentScrollView中;
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}

/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 * 只要scrollView在滚动，就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > self.titleScrollView.subviews.count - 1) return;
    
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    CJLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    CJLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count) ? nil : self.titleScrollView.subviews[rightIndex];
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    
    // 设置label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
