//
//  SkyLeftCollectionViewItems.m
//  LeftCollectionViewItemsFlowLayout
//
//  Created by fangd@silviscene.com on 2017/5/8.
//  Copyright © 2017年 skm. All rights reserved.
//

#import "SkyLeftCollectionViewItems.h"
#import <AVFoundation/AVFoundation.h>
#import "Header.h"
@interface SkyLeftCollectionViewItems ()
@property (nonatomic,strong)UILabel *label;
@end
@implementation SkyLeftCollectionViewItems
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView
{

    
    self.label = [[UILabel alloc]init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    self.label.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.label];
    self.label.backgroundColor = kRGBColor(85, 160, 44);
}
- (void)setModel:(SkyNameModel *)model
{
    if (_model != model) {
        _model = model;
        [self setupWithModel:model];
    }
}
//设置label.frame，避免items重用是出现错误
- (void)setupWithModel:(SkyNameModel *)model
{
    self.label.text = model.NAME;
    self.label.frame = CGRectMake(0, 0, model.widthCount+20, 44);
    //    self.contentView倒圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.label.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.label.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.label.layer.mask = maskLayer;

}

@end
