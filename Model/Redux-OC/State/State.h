//
//  State.h
//  PhantomSteward
//
//  Created by LiangHao on 10/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface State : NSObject

@property (nonatomic, strong) NSArray* todoList;
/**
 千万别这么使用。一定不要用可变。这里仅仅是种特殊的展示而已
 */
@property (nonatomic, strong) NSMutableArray* allOperationList;

@end
