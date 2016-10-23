//
//  CJHomeChildTableHeaderView.m
//  DailyShopping
//
//  Created by Cijian on 2016/10/20.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJHomeChildTableHeaderView.h"
#import "CJImageView+CJGesture.h"
#import "LXNetworking.h"
#import <YYModel/YYModel.h>
#import "CJURL.h"
@interface CJHomeChildTableHeaderView () <UIScrollViewDelegate>

/**
 轮播图 - scrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *bannerView;
/**
 页数控制
 */
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
/**
 计时器
 */
@property (nonatomic, strong) NSTimer *timer;
/**
 轮播图位置索引
 */
@property (nonatomic, assign) NSInteger index;


@end

typedef enum {
    
    StatusDefault = 0,//默认
    StatusFirst = 1,//第一张图片
    StatusLast = 2//最后一张图片
    
}BannerImageStatus;

//轮播图高度
static CGFloat bannerViewHeight = 0;

@implementation CJHomeChildTableHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    //获取轮播图数据
//    [LXNetworking getWithUrl:CJHomeCarouselURL params:nil success:^(id response) {
//        
//        NSArray *arr = response;
//        NSMutableArray *bannerArrM = [NSMutableArray array];
//        for (NSDictionary *dict in arr) {
//            @autoreleasepool {
//                CJHomeChildTableBannerModel *model = [CJHomeChildTableBannerModel yy_modelWithJSON:dict];
//                if (model) {
//                    [bannerArrM addObject:model];
//                }
//            }
//        }
//        
//        self.bannerModelArr = bannerArrM;
//        
//    } fail:^(NSError *error) {
//        NSLog(@"---+++ %@",error);
//    } showHUD:YES andController:nil];
}

#pragma mark -加载轮播图
- (void)setBannerModelArr:(NSArray *)bannerModelArr
{
    _bannerModelArr = bannerModelArr;
    
    //设置bannerView的contentSize
    _bannerView.contentSize = CGSizeMake(CWidth * (bannerModelArr.count + 2), 0);
    
    //设置pagecontrol
    _pageControl.numberOfPages = bannerModelArr.count;
    //获取轮播图高度
    //轮播图宽高比 3:8
    CGFloat bannerScale = 3/8.0;
    bannerViewHeight = CWidth * bannerScale;
    //如果数据为空
    if (bannerModelArr.count == 0) {
        UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CWidth, bannerViewHeight)];
        img.image = [UIImage imageNamed:@"photo"];
        [_bannerView addSubview:img];
        return;
    }
    
    for (NSInteger i = 0; i < bannerModelArr.count + 2; i++) {
        
        if (i == 0) {
            [self setUpImageWithIndex:0 withValue:StatusFirst];
        }else if (i == bannerModelArr.count +1)
        {
            [self setUpImageWithIndex:bannerModelArr.count +1 withValue:StatusLast];
        }else
        {
            [self setUpImageWithIndex:i withValue:StatusDefault];
        }
        
    }
    [_bannerView setContentOffset:CGPointMake(CWidth, 0)];
    _bannerView.delegate = self;
    _index = 1;
    [self addMyTimer];
    
}
#pragma mark -创建轮播图片
- (void)setUpImageWithIndex:(NSInteger)i withValue:(BannerImageStatus)status
{
    //创建轮播图片
    CJImageView *imgView = [[CJImageView alloc] initWithFrame:CGRectMake(CWidth * i, 0, CWidth, bannerViewHeight)];
    //获取模型
    CJHomeChildTableBannerModel *model;
    switch (status) {
        case StatusFirst:
            model = _bannerModelArr.lastObject;
            break;
        case StatusLast:
            model = _bannerModelArr.firstObject;
            break;
        default:
            model = _bannerModelArr[i-1];
            break;
    }
    //添加手势及响应事件
    [imgView cj_addTapGestureWithSelector:@selector(bannerImageClick:) withImageURL:model.home_banner_2 andAnswer:self];
    //图片描述
    imgView.subject = model.subject;
    //跳转id
    imgView.subject_id = model.subject_id;
    
    [_bannerView addSubview:imgView];
    
}
#pragma mark -监听拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _bannerView && _timer) {
        _index = scrollView.contentOffset.x /CWidth;
        [self removeMyTimer];
    }
}
#pragma mark -拖动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != _bannerView) return;
    //2秒后计时器生效
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_bannerView.dragging == NO) {
            [self addMyTimer];
        }
    });
}
#pragma mark -轮播图滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView != _bannerView) return;
    //scrollView滚动到第一张
    if (scrollView.contentOffset.x == CWidth * (_bannerModelArr.count +1)) {
        _pageControl.currentPage = 0;
        [scrollView setContentOffset:CGPointMake(CWidth, 0) animated:NO];
        
        //scrollView滚动到最后一张
    }else if (scrollView.contentOffset.x == 0)
    {
        [scrollView setContentOffset:CGPointMake(CWidth * _bannerModelArr.count, 0) animated:NO];
        _pageControl.currentPage = _bannerModelArr.count - 1;
    }else
    {
        _pageControl.currentPage = scrollView.contentOffset.x /CWidth -1;
    }
    
}
#pragma mark -添加定时器
- (void)addMyTimer
{
    if (_timer == nil) {
        //创建计时器
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(bannerTimerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}
#pragma mark -移除定时器
- (void)removeMyTimer
{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}
#pragma mark -计时器响应事件
- (void)bannerTimerAction
{
    _index ++;
    if (_index  == _bannerModelArr.count + 2) {
        _index = 2;
        
    }
    [_bannerView setContentOffset:CGPointMake(_index * CWidth, 0) animated:YES];
    //    _pageControl.currentPage = _index - 2;
}

#pragma mark -轮播图点击事件
- (void)bannerImageClick:(UITapGestureRecognizer *)tap
{
    CJImageView *img = (CJImageView *)tap.view;
}

- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
