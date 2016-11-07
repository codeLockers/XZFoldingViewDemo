//
//  XZCell.m
//  XZFoldingViewDemo
//
//  Created by 徐章 on 2016/11/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZCell.h"
#import <Masonry/Masonry.h>

@implementation XZCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        }];

        self.titleLab = [[UILabel alloc] init];
        [view addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(view).offset(10);
            make.centerY.equalTo(view);
        }];

    }
    
    return self;
}

@end
