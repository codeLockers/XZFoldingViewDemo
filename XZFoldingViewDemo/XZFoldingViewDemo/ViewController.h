//
//  ViewController.h
//  XZFoldingViewDemo
//
//  Created by 徐章 on 2016/11/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface XZSectionModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSArray *data;

@end
