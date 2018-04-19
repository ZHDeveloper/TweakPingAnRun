//
//  ModiyfDataViewController.m
//  OC-Test
//
//  Created by ZhiHua Shen on 2018/4/8.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

#import "ModiyfDataViewController.h"
#import "ModifyInputCell.h"
#import "Masonry.h"

@interface ModiyfDataViewController () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
}

@end

@implementation ModiyfDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改数据";
    
    UIView *view = self.view;
    view.backgroundColor = [UIColor whiteColor];
    
    [self initialUI];
    
    //版本适配
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)initialUI {
  
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;

    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[ModifyInputCell class] forCellReuseIdentifier:@"cell"];
    
    UIView *view = [self view];
    [view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    
    self.navigationItem.rightBarButtonItem = saveItem;
    
}

- (void)saveAction {
    
    ModifyInputCell *stepCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    ModifyInputCell *rateCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    NSInteger steps = stepCell.inputText.text.integerValue;
    NSInteger rate = rateCell.inputText.text.integerValue;
    
    [[NSUserDefaults standardUserDefaults] setInteger:steps forKey:@"stepCount"];
    [[NSUserDefaults standardUserDefaults] setInteger:rate forKey:@"heartRate"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"mofidyDate"];

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ModifyInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.idxPath = indexPath;
    
    return cell;
}

@end
