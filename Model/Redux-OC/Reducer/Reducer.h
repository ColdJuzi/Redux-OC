//
//  Reducer.h
//  PhantomSteward
//
//  Created by LiangHao on 10/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <Foundation/Foundation.h>
@class State;
@class Action;

typedef void(^ReducerBlock)(State **, Action *);

@interface Reducer : NSObject

+ (NSArray *)reducers;

@end
