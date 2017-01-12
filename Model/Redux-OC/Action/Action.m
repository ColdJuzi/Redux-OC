//
//  Action.m
//  PhantomSteward
//
//  Created by LiangHao on 10/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "Action.h"

@interface Action ()

@property (nonatomic, assign, readwrite) ReduxActionType type;
@property (nonatomic, strong, readwrite) id params;

@end

@implementation Action

- (instancetype)initWithReduxActionType:(ReduxActionType)type
                                 params:(id)params {
    self = [super init];
    if (self) {
        _type = type;
        _params = params;
    }
    return self;
}

@end
