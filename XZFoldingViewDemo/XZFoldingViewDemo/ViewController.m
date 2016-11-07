//
//  ViewController.m
//  XZFoldingViewDemo
//
//  Created by 徐章 on 2016/11/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "XZSectionHeadView.h"
#import "XZCell.h"

@interface XZSectionModel()



@end

@implementation XZSectionModel



@end


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,XZSectionHeadViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionHeadArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self loadUI];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private_Methods
- (UIColor *)randomColor{
    
    NSInteger red = arc4random()%255;
    NSInteger green = arc4random()%255;
    NSInteger blue = arc4random()%255;
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];

}

#pragma mark - Load_Data
- (void)loadData{
    
    XZSectionModel *model1 = [[XZSectionModel alloc] init];
    model1.title = @"exam 1";
    model1.selected = NO;
    model1.data = @[@"question 1-1",@"question 1-2",@"question 1-3",@"question 1-4"];
    
    XZSectionModel *model2 = [[XZSectionModel alloc] init];
    model2.title = @"exam 2";
    model2.selected = NO;
    model2.data = @[@"question 2-1",@"question 2-2",@"question 2-3"];
    
    XZSectionModel *model3 = [[XZSectionModel alloc] init];
    model3.title = @"exam 3";
    model3.selected = NO;
    model3.data = @[@"question 3-1",@"question 3-2"];
    
    XZSectionModel *model4 = [[XZSectionModel alloc] init];
    model4.title = @"exam 4";
    model4.selected = NO;
    model4.data = @[@"question 4-1",@"question 4-2",@"question 4-3",@"question 4-4",@"question 4-5",@"question 4-6"];
    
    XZSectionModel *model5 = [[XZSectionModel alloc] init];
    model5.title = @"exam 5";
    model5.selected = NO;
    model5.data = @[@"question 5-1",@"question 5-2",@"question 5-3"];
    
    XZSectionModel *model6 = [[XZSectionModel alloc] init];
    model6.title = @"exam 6";
    model6.selected = NO;
    model6.data = @[@"question 6-1",@"question 6-2",@"question 6-3",@"question 6-4"];
    
    self.dataArray = @[model1,model2,model3,model4,model5,model6];
    
    self.sectionHeadArray = [NSMutableArray new];
}

#pragma mark - Load_UI
- (void)loadUI{
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0f green:209/255.0f blue:162/255.0f alpha:1.0f];
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.backgroundColor = [UIColor colorWithRed:238/255.0f green:237/255.0f blue:238/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView_Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

   return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    XZSectionModel *model = self.dataArray[section];
    return model.selected ? model.data.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    XZSectionModel *model = self.dataArray[section];
    
    return model.selected ? 40.0f : 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.sectionHeadArray.count >= section+1) {
        return self.sectionHeadArray[section];
    }
    
    
    XZSectionModel *model = self.dataArray[section];

    XZSectionHeadView *headView = [[XZSectionHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60) sectionModel:model];
    headView.tag = section;
    headView.delegate = self;

    [self.sectionHeadArray addObject:headView];
    
    return headView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XZCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XZCell class])];
    if (!cell) {
        
        cell = [[XZCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([XZCell class])];
        
        cell.backgroundColor = tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    XZSectionModel *model = self.dataArray[indexPath.section];
    cell.titleLab.text = model.data[indexPath.row];
    
    return cell;
    
}

#pragma mark - XZSectionHeadViewDelegate
- (void)sectionHeadViewFoldButtonClick:(XZSectionHeadView *)headView{

    XZSectionModel *model = self.dataArray[headView.tag];
    model.selected = !model.selected;
    
    if (model.selected) {
        
        [self.tableView insertRowsAtIndexPaths:[self getReloadIndexPath:model.data section:headView.tag] withRowAnimation:UITableViewRowAnimationFade];
        
    }else{
        
        [self.tableView deleteRowsAtIndexPaths:[self getReloadIndexPath:model.data section:headView.tag] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Private_Methods
- (NSMutableArray *)getReloadIndexPath:(NSArray *)dataArray section:(NSInteger)section{

    NSMutableArray *indexPathArray = [NSMutableArray new];
    
    for (NSInteger i = 0; i< dataArray.count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [indexPathArray addObject:indexPath];
    }
    
    return indexPathArray;
}

@end
