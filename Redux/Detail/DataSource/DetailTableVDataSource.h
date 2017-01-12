//
//  DetailTableVDataSource.h
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailTableVDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier;
- (RACSubject *)getReloadTableVSubject;

- (void)deleteTodoWithIndexPath:(NSIndexPath *)indexPath;
- (void)doingTodoWithIndexPath:(NSIndexPath *)indexPath;
- (void)finishTodoWithIndexPath:(NSIndexPath *)indexPath;
- (void)removeTodoWithIndexPath:(NSIndexPath *)indexPath;

@end
