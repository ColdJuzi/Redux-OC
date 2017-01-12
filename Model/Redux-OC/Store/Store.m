//
//  Store.m
//  PhantomSteward
//
//  Created by LiangHao on 10/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "Store.h"
#import "State.h"
#import "Reducer.h"

@interface Store ()

@property (nonatomic, strong, readwrite) RACSignal* rac_observer;
@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, strong) State* state;
@property (nonatomic, strong) NSArray <ReducerBlock>* reducers;

@end

@implementation Store

static Store* instance = nil;
+ (Store *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Store alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serialQueue = dispatch_queue_create("Redux-OC Action Queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (RACSignal *)rac_observer {
    if (!_rac_observer) {
        _rac_observer = [RACObserve(self, state) replayLast];
    }
    return _rac_observer;
}

- (State *)state {
    if (!_state) {
        _state = [[State alloc] init];
    }
    return _state;
}

- (NSArray<ReducerBlock> *)reducers {
    if (!_reducers) {
        _reducers = [Reducer reducers];
    }
    return _reducers;
}

- (void)dispatchWithAction:(Action *)action {
    dispatch_async(self.serialQueue, ^{
        State* newState = [self.state copy];
        for (ReducerBlock block in self.reducers) {
            block(&newState, action);
        }
        self.state = newState;
    });
}

@end
