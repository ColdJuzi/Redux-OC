//
//  Store.h
//  PhantomSteward
//
//  Created by LiangHao on 10/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Action;

@interface Store : NSObject

@property (nonatomic, strong, readonly) RACSignal* rac_observer;

+ (Store *)sharedInstance;

- (void)dispatchWithAction:(Action *)action;

@end
