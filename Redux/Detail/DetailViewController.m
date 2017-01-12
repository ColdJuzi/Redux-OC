//
//  DetailViewController.m
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableVDataSource.h"

#import "UITableView+HiddenExcessLine.h"
#import "UITableViewCell+CellLineLeftMargin.h"

@interface DetailViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView* todoListTableV;

@property (nonatomic, strong) DetailTableVDataSource* detailDataSource;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildView];
    [self bindRAC];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.title = @"Detail";
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIBarButtonItem* addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                      target:self
                                                                                      action:@selector(addTodo:)];
    self.tabBarController.navigationItem.rightBarButtonItems = @[addBarButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - BarButtonItem
- (void)addTodo:(UIBarButtonItem *)sender {
    UIAlertController* createAlerC = [UIAlertController alertControllerWithTitle:@"Remind"
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    [createAlerC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [textField setPlaceholder:@"Please write todo name."];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [self removeTextFieldChangeNotification];
                                                         }];
    [createAlerC addAction:cancelAction];
    UIAlertAction* createAction = [UIAlertAction actionWithTitle:@"Create"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [self removeTextFieldChangeNotification];
                                                             NSString* todoNameStr = createAlerC.textFields.firstObject.text;
                                                             Action* createAction = [[Action alloc] initWithReduxActionType:ReduxActionTypeAddToDo
                                                                                                                     params:todoNameStr];
                                                             [[Store sharedInstance] dispatchWithAction:createAction];
                                                         }];
    createAction.enabled = NO;
    [createAlerC addAction:createAction];
    [self presentViewController:createAlerC
                       animated:YES
                     completion:nil];
}

#pragma mark - BuildView
- (void)buildView {
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _detailDataSource = [[DetailTableVDataSource alloc] initWithCellIdentifier:@"DetailCellIdentifier"];
    
    _todoListTableV = [[UITableView alloc] initWithFrame:CGRectZero
                                                               style:UITableViewStylePlain];
    self.todoListTableV.delegate = self;
    self.todoListTableV.dataSource = self.detailDataSource;
    [self.view addSubview:self.todoListTableV];
    [self.todoListTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.todoListTableV setExtraCellLineHidden];
    [self.todoListTableV setEditing:YES];
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

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction* deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                            title:@"Delete"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              [self.detailDataSource deleteTodoWithIndexPath:indexPath];
                                                                          }];
    [deleteAction setBackgroundColor:[UIColor redColor]];
    UITableViewRowAction* doingAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                           title:@"Doing"
                                                                         handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                             [self.detailDataSource doingTodoWithIndexPath:indexPath];
                                                                         }];
    [doingAction setBackgroundColor:[UIColor orangeColor]];
    UITableViewRowAction* finishAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                            title:@"Finish"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              [self.detailDataSource finishTodoWithIndexPath:indexPath];
                                                                          }];
    [finishAction setBackgroundColor:[UIColor greenColor]];
    
    UITableViewRowAction* removeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                            title:@"Remove"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              [self.detailDataSource removeTodoWithIndexPath:indexPath];
                                                                          }];
    [finishAction setBackgroundColor:[UIColor blueColor]];
    return @[deleteAction, doingAction, finishAction, removeAction];
}

#pragma mark - BindRAC
- (void)bindRAC {
    [self.detailDataSource.getReloadTableVSubject subscribeNext:^(id  _Nullable x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.todoListTableV reloadData];
        });
    }];
}

#pragma mark - UITextFieldNotification
- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField* nameTF = alertController.textFields.firstObject;
        UIAlertAction* createAction = alertController.actions.lastObject;
        createAction.enabled = nameTF.text.length >= 1;
    }
}

- (void)removeTextFieldChangeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
