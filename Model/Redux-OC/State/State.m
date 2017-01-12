//
//  State.m
//  PhantomSteward
//
//  Created by LiangHao on 10/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "State.h"

@interface State () <NSCopying>
@end

@implementation State

- (instancetype)init {
    self = [super init];
    if (self) {
        _allOperationList = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return self;
}

@end
