//
//  ToDoItem.h
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ToDoState.h"

@interface ToDoItem : JSONModel

@property (nonatomic, assign) NSInteger todoId;
@property (nonatomic, strong) NSString<Optional>* todoTitle;
@property (nonatomic, assign) ToDoState todoState;
@property (nonatomic, strong) NSNumber<Optional>* todoCreateDate;
@property (nonatomic, strong) NSNumber<Optional>* todoUpdateDate;

- (instancetype)initNewTodoWithName:(NSString *)nameStr;

@end
