//
//  TotalViewController.m
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "TotalViewController.h"
#import "TotalTableVDataSource.h"

#import "UITableView+HiddenExcessLine.h"
#import "UITableViewCell+CellLineLeftMargin.h"

@interface TotalViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView* todoListTableV;

@property (nonatomic, strong) TotalTableVDataSource* totalDataSource;

@end

@implementation TotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildView];
    [self bindRAC];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.title = @"Total";
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIBarButtonItem* forwardBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(foraredBarButtonAction:)];
    UIBarButtonItem* backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@">"
                                                                          style:UIBarButtonItemStyleDone
                                                                         target:self
                                                                         action:@selector(backBarButtonAction:)];
    self.tabBarController.navigationItem.rightBarButtonItems = @[backBarButtonItem, forwardBarButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - BarButtonAction
- (void)foraredBarButtonAction:(UIBarButtonItem *)sender {
    [self.totalDataSource toViewSelectedTodoDetail:ToViewOrderBefore];
}

- (void)backBarButtonAction:(UIBarButtonItem *)sender {
    [self.totalDataSource toViewSelectedTodoDetail:ToViewOrderAfrer];
}

#pragma mark - BuildView
- (void)buildView {
    _totalDataSource = [[TotalTableVDataSource alloc] initWithCellIdentifier:@"TotalCellIdentifier"];
    _todoListTableV = [[UITableView alloc] initWithFrame:CGRectZero
                                                   style:UITableViewStylePlain];
    self.todoListTableV.delegate = self;
    self.todoListTableV.dataSource = self.totalDataSource;
    [self.view addSubview:self.todoListTableV];
    [self.todoListTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.todoListTableV setExtraCellLineHidden];
    [self.todoListTableV setAllowsSelection:NO];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setLayoutMarginsZero];
}

#pragma mark - BindRAC
- (void)bindRAC {
    [self.totalDataSource.getReloadTableVSubject subscribeNext:^(id  _Nullable x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.todoListTableV reloadData];
        });
    }];
}

@end
