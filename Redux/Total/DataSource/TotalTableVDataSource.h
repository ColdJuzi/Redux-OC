//
//  TotalTableVDataSource.h
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ToViewOrderBefore,
    ToViewOrderAfrer,
} ToViewOrder;

@interface TotalTableVDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier;
- (RACSubject *)getReloadTableVSubject;

- (void)toViewSelectedTodoDetail:(ToViewOrder)order;

@end
