//
//  ToDoTotalViewModel.h
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoTotalViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray* allToDoListArray;

- (RACSubject *)getReloadTableVSubject;

//  这是特意写给更新的。为了省事。。
- (void)refreshAllTodoList;

@end
