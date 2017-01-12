//
//  ToDoItem.m
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"todoId": @"id",
                                                                  @"todoTitle": @"title",
                                                                  @"todoState": @"state",
                                                                  @"todoCreateDate": @"create_time",
                                                                  @"todoUpdateDate": @"edit_time",}];
}

#pragma mark - Init
- (instancetype)initNewTodoWithName:(NSString *)nameStr {
    self = [super init];
    if (self) {
        _todoTitle = nameStr;
        _todoId = [[NSDate new] timeIntervalSince1970];
        _todoCreateDate = [NSNumber numberWithUnsignedLong:[[NSDate new] timeIntervalSince1970]];
        _todoState = ToDoStateNew;
    }
    return self;
}

@end
