//
//  ToDoViewModel.m
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "ToDoViewModel.h"

@interface ToDoViewModel ()

@property (nonatomic, strong) RACDisposable* stateObserver;
@property (nonatomic, strong, readonly) RACSubject* reloadSignal;
@property (nonatomic, strong, readwrite) NSArray* allToDoListArray;

@end

@implementation ToDoViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _allToDoListArray = @[];
        [self bindRAC];
    }
    return self;
}

#pragma mark - BindRAC
- (void)bindRAC {
    _reloadSignal = [RACSubject subject];
    
    self.stateObserver = [[Store sharedInstance].rac_observer subscribeNext:^(State* state) {
        if (![self.allToDoListArray isEqualToArray:state.todoList]) {
            self.allToDoListArray = [state.todoList copy];
            [self refreshAllTodoList];
        }
    }];
}

#pragma mark - Refresh
- (void)refreshAllTodoList {
    [self.reloadSignal sendNext:@1];
}

- (RACSubject *)getReloadTableVSubject {
    return _reloadSignal;
}

@end
