//
//  ToDoViewModel.h
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray* allToDoListArray;

- (RACSubject *)getReloadTableVSubject;

@end
