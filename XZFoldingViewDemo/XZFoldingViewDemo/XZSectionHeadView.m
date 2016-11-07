//
//  XZSectionHeadView.m
//  XZFoldingViewDemo
//
//  Created by 徐章 on 2016/11/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZSectionHeadView.h"
#import <Masonry/Masonry.h>

#define TitleLabHeight 40.0f
#define TitleLabWidth 100.0f
#define FoldBtnHeight 30.0f
#define FoldBtnWidth 70.0f

@interface XZSectionHeadView()

@property (nonatomic, strong) XZSectionModel *model;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *foldView;
@property (nonatomic, strong) UILabel *titleLab;

@end


@implementation XZSectionHeadView

- (id)initWithFrame:(CGRect)frame sectionModel:(XZSectionModel *)model{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.model = model;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self loadTitleLab];
        [self loadFoldBtn];
    }
    
    return self;
}

#pragma mark - Load_UI
-(void)loadTitleLab{

    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, (self.frame.size.height - TitleLabHeight)/2.0f, 100, TitleLabHeight)];
    self.titleLab.text = self.model.title;
    [self addSubview:self.titleLab];

}

- (void)loadFoldBtn{

    self.foldView = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - FoldBtnWidth - 20, (self.frame.size.height - FoldBtnHeight)/2.0f, FoldBtnWidth, FoldBtnHeight)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"共两题";
    label.font = [UIFont systemFontOfSize:11.0f];
    [self.foldView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.foldView).offset(5);
        make.centerY.equalTo(self.foldView);
    }];
    
    self.arrowImageView = [[UIImageView alloc] init];
    self.arrowImageView.image = [UIImage imageNamed:@"arrow_down"];
    self.arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.foldView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.foldView).offset(-5);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.centerY.equalTo(self.foldView);
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(foldBtn_Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.foldView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.foldView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self addSubview:self.foldView];
}

#pragma mark - Private_Methods
- (void)foldBtn_Pressed{

    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionHeadViewFoldButtonClick:)]) {
        [self.delegate sectionHeadViewFoldButtonClick:self];
        [self changeHeight];
    }
}

#pragma mark - Public_Methods
- (void)changeHeight{

    CGFloat height = self.model.selected ? 40 : 60;
    UIColor *color = self.model.selected ? [UIColor colorWithRed:238/255.0f green:237/255.0f blue:238/255.0f alpha:1.0f] : [UIColor whiteColor];
    CGFloat rotate = self.model.selected ? 0.0000001-M_PI : 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
        self.titleLab.frame = CGRectMake(10, (self.frame.size.height - TitleLabHeight)/2.0f, 100, TitleLabHeight);
        self.foldView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - FoldBtnWidth - 20, (self.frame.size.height - FoldBtnHeight)/2.0f, FoldBtnWidth, FoldBtnHeight);
        self.arrowImageView.transform = CGAffineTransformMakeRotation(rotate);
        self.backgroundColor = color;
    }];
}


@end
