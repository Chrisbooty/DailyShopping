//
//  CJRecommandTableCell.m
//  DailyShopping
//
//  Created by Cijian on 2016/11/9.
//  Copyright © 2016年 Cijian. All rights reserved.
//

#import "CJRecommandTableCell.h"
#import "CJRecommandGoodView.h"

@interface CJRecommandTableCell ()

/**
 描述 - UILabel
 */
@property (weak, nonatomic) IBOutlet UILabel *subjectL;
/**
 scrollView容器
 */
@property (weak, nonatomic) IBOutlet UIScrollView *containerView;

@end

@implementation CJRecommandTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)viewMoreClick {
    
}

- (void)setModel:(CJRecommandGroupModel *)model
{
    _model = model;
    _subjectL.text = model.subject;
    
//    for (UIView *obj in _containerView.subviews) {
//        [obj removeFromSuperview];
//    }
    NSInteger num = model.recommandGoodModels.count > 10 ? 10 : model.recommandGoodModels.count;
    if (_containerView.subviews.count > 5) {
        for (NSInteger i = 0; i < num; i++) {
            
            CJRecommandGoodView *goodView = _containerView.subviews[i];
            goodView.model = model.recommandGoodModels[i];
            _containerView.contentOffset = CGPointZero;
        }
    }else
    {
        [self createGoodView];
    }
}

- (void)createGoodView
{
    CGFloat spacing = 10;
    CGFloat viewH = 186;
    CGFloat viewW = 120;
    _containerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 188);
    
    for (NSInteger i = 0; i < _model.recommandGoodModels.count; i++) {
        
        @autoreleasepool {
            CJRecommandGoodView *goodView = [CJRecommandGoodView view];
            CJRecommandGoodModel *goodModel = _model.recommandGoodModels[i];
            goodView.frame = CGRectMake( spacing * (i+1) + viewW * i, 0, viewW, viewH);
            goodView.model = goodModel;
            [_containerView addSubview:goodView];
            
            if (i == _model.recommandGoodModels.count - 1) {
                _containerView.contentSize =CGSizeMake(CGRectGetMaxX(goodView.frame) + spacing, 0);
            }
        }
    }
}

@end
