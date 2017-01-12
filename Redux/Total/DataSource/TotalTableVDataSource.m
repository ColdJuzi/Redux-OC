//
//  TotalTableVDataSource.m
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "TotalTableVDataSource.h"
#import "ToDoTotalViewModel.h"
#import "ToDoItem.h"

#import "DetailTableViewCell.h"

@interface TotalTableVDataSource ()
{
    NSString* cellIdentifierStr;
    NSInteger selectedIndex;
}

@property (nonatomic, strong) ToDoTotalViewModel* todoVM;

@end

@implementation TotalTableVDataSource

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier {
    self = [super init];
    if (self) {
        cellIdentifierStr = cellIdentifier;
        selectedIndex = 0;
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.todoVM.allToDoListArray objectAtIndex:selectedIndex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierStr];
    if (!cell) {
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:cellIdentifierStr];
    }
    ToDoItem* todoItem = [[self.todoVM.allToDoListArray objectAtIndex:selectedIndex] objectAtIndex:indexPath.row];
    cell.textLabel.text = todoItem.todoTitle;
    [cell drawTodoCurrentState:todoItem.todoState];
    return cell;
}

#pragma mark - ViewModel
- (ToDoTotalViewModel *)todoVM {
    if (!_todoVM) {
        _todoVM = [[ToDoTotalViewModel alloc] init];
    }
    return _todoVM;
}

#pragma mark - Header
- (RACSubject *)getReloadTableVSubject {
    return self.todoVM.getReloadTableVSubject;
}

- (void)toViewSelectedTodoDetail:(ToViewOrder)order {
    switch (order) {
        case ToViewOrderBefore:
            selectedIndex = selectedIndex <= 0 ? selectedIndex : selectedIndex - 1;
            break;
        case ToViewOrderAfrer:
            selectedIndex = selectedIndex >= [self.todoVM.allToDoListArray count] - 1 ? selectedIndex : selectedIndex + 1;
        default:
            break;
    }
    [self.todoVM refreshAllTodoList];
}

@end
