//
//  DetailTableVDataSource.m
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "DetailTableVDataSource.h"
#import "ToDoViewModel.h"
#import "ToDoItem.h"

#import "DetailTableViewCell.h"

@interface DetailTableVDataSource ()
{
    NSString* cellIdentifierStr;
}

@property (nonatomic, strong) ToDoViewModel* todoVM;

@end

@implementation DetailTableVDataSource

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier {
    self = [super init];
    if (self) {
        cellIdentifierStr = cellIdentifier;
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.todoVM.allToDoListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierStr];
    if (!cell) {
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifierStr];
    }
    ToDoItem* todoItem = [self.todoVM.allToDoListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = todoItem.todoTitle;
    [cell drawTodoCurrentState:todoItem.todoState];
    return cell;
}

#pragma mark - ViewModel
- (ToDoViewModel *)todoVM {
    if (!_todoVM) {
        _todoVM = [[ToDoViewModel alloc] init];
    }
    return _todoVM;
}

#pragma mark - Header 
- (RACSubject *)getReloadTableVSubject {
    return self.todoVM.getReloadTableVSubject;
}

#pragma mark - Todo Operation
- (void)deleteTodoWithIndexPath:(NSIndexPath *)indexPath {
    ToDoItem* todoItem = [self.todoVM.allToDoListArray objectAtIndex:indexPath.row];
    Action* deleteAction = [[Action alloc] initWithReduxActionType:ReduxActionTypeEditToDo
                                                            params:@{@"id" : [NSNumber numberWithInteger:todoItem.todoId],
                                                                     @"state" : [NSNumber numberWithUnsignedInteger:ToDoStateDelete]}];
    [[Store sharedInstance] dispatchWithAction:deleteAction];
}

- (void)doingTodoWithIndexPath:(NSIndexPath *)indexPath {
    ToDoItem* todoItem = [self.todoVM.allToDoListArray objectAtIndex:indexPath.row];
    Action* deleteAction = [[Action alloc] initWithReduxActionType:ReduxActionTypeEditToDo
                                                            params:@{@"id" : [NSNumber numberWithInteger:todoItem.todoId],
                                                                     @"state" : [NSNumber numberWithUnsignedInteger:ToDoStateDoing]}];
    [[Store sharedInstance] dispatchWithAction:deleteAction];
}

- (void)finishTodoWithIndexPath:(NSIndexPath *)indexPath {
    ToDoItem* todoItem = [self.todoVM.allToDoListArray objectAtIndex:indexPath.row];
    Action* deleteAction = [[Action alloc] initWithReduxActionType:ReduxActionTypeEditToDo
                                                            params:@{@"id" : [NSNumber numberWithInteger:todoItem.todoId],
                                                                     @"state" : [NSNumber numberWithUnsignedInteger:ToDoStateFinish]}];
    [[Store sharedInstance] dispatchWithAction:deleteAction];
}

- (void)removeTodoWithIndexPath:(NSIndexPath *)indexPath {
    ToDoItem* todoItem = [self.todoVM.allToDoListArray objectAtIndex:indexPath.row];
    Action* deleteAction = [[Action alloc] initWithReduxActionType:ReduxActionTypeRemoveToDo
                                                            params:@{@"id" : [NSNumber numberWithInteger:todoItem.todoId],}];
    [[Store sharedInstance] dispatchWithAction:deleteAction];
}

@end
