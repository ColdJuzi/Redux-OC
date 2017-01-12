//
//  Reducer.m
//  PhantomSteward
//
//  Created by LiangHao on 10/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "Reducer.h"
#import "State.h"
#import "Action.h"
#import "ToDoItem.h"
#import "JSONModel+Assign.h"

@implementation Reducer

+ (NSArray *)reducers {
    return @[[self todoReducer], [self operationReducer]];
}

+ (ReducerBlock)todoReducer {
    ReducerBlock block = ^(State **state, Action *action) {
        if (state == NULL) {
            return;
        }
        
        State* newState = *state;
        switch (action.type) {
            case ReduxActionTypeQueryAllToDo: {
                NSMutableArray* todoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
                for (NSDictionary* todoInfoDict in (NSArray *)action.params) {
                    ToDoItem* todoItem = [[ToDoItem alloc] initWithDictionary:todoInfoDict
                                                                        error:nil];
                    if (todoItem) {
                        [todoMutableArray addObject:todoItem];
                    }
                }
                newState.todoList = todoMutableArray;
                [newState.allOperationList addObject:todoMutableArray];
                
            }
                break;
            case ReduxActionTypeAddToDo: {
                NSMutableArray* todoMutablist = [newState.todoList mutableCopy];
                ToDoItem* createTodoItem = [[ToDoItem alloc] initNewTodoWithName:(NSString *)action.params];
                if (createTodoItem) {
                    [todoMutablist addObject:createTodoItem];
                    newState.todoList = todoMutablist;
                    [newState.allOperationList addObject:todoMutablist];
                }
            }
                break;
            case ReduxActionTypeEditToDo: {
                NSMutableArray* todoMutablist = [newState.todoList mutableCopy];
                ToDoItem* oldTodoItem = [[self class] queryTodoItemWithToDoId:[[(NSDictionary *)action.params objectForKey:@"id"] integerValue] todoList:todoMutablist];
                if (oldTodoItem) {
                    NSMutableDictionary* changeTodoDict = [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)action.params];
                    [changeTodoDict setObject:[NSNumber numberWithUnsignedLong:[[NSDate new] timeIntervalSince1970]]
                                       forKey:@"edit_time"];
                    NSInteger index = [todoMutablist indexOfObject:oldTodoItem];
                    ToDoItem* changeTodoItem = (ToDoItem *)[JSONModel objectAssignWithOldItem:oldTodoItem
                                                                      changeInfo:changeTodoDict];
                    [todoMutablist replaceObjectAtIndex:index withObject:changeTodoItem];
                    newState.todoList = todoMutablist;
                    [newState.allOperationList addObject:todoMutablist];
                }
            }
                break;
            case ReduxActionTypeRemoveToDo: {
                NSMutableArray* todoMutablist = [newState.todoList mutableCopy];
                ToDoItem* removeTodoItem = [[self class] queryTodoItemWithToDoId:[[(NSDictionary *)action.params objectForKey:@"id"] integerValue] todoList:todoMutablist];
                if (removeTodoItem) {
                    [todoMutablist removeObject:removeTodoItem];
                    newState.todoList = todoMutablist;
                    [newState.allOperationList addObject:todoMutablist];
                }
            }
                break;
            default:
                break;
        }
    };
    return block;
}

+ (ReducerBlock)operationReducer {
    ReducerBlock block = ^(State **state, Action *action) {
        if (state == NULL) {
            return;
        }
        switch (action.type) {
            case ReduxActionTypeQueryAllToDo:
                break;
                
            default:
                break;
        }
    };
    return block;
}

#pragma mark - JudgeTodoItem
+ (ToDoItem *)queryTodoItemWithToDoId:(NSInteger)todoId todoList:(NSArray *)todoArray {
    for (ToDoItem* todoItem in todoArray) {
        if (todoItem.todoId == todoId) {
            return todoItem;
        }
    }
    return nil;
}

@end
