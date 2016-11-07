//
//  XZSectionHeadView.h
//  XZFoldingViewDemo
//
//  Created by 徐章 on 2016/11/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class XZSectionHeadView;

@protocol XZSectionHeadViewDelegate <NSObject>

- (void)sectionHeadViewFoldButtonClick:(XZSectionHeadView *)headView;

@end


@interface XZSectionHeadView : UIView

@property (nonatomic, weak) id<XZSectionHeadViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame sectionModel:(XZSectionModel *)model;

@end
