//
//  Action.h
//  PhantomSteward
//
//  Created by LiangHao on 10/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActioneType.h"

@interface Action : NSObject

@property (nonatomic, assign, readonly) ReduxActionType type;
@property (nonatomic, strong, readonly) id params;

- (instancetype)initWithReduxActionType:(ReduxActionType)type
                                 params:(id)params;

@end
