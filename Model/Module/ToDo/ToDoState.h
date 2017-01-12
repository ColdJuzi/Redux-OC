//
//  ToDoState.h
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#ifndef ToDoState_h
#define ToDoState_h

typedef enum : NSUInteger {
    ToDoStateNew,
    ToDoStateDoing,
    ToDoStateFinish,
    ToDoStateDelete,
} ToDoState;

#endif 
