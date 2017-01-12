//
//  ViewController.m
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* todoInitDataFileStr = [[NSBundle mainBundle] pathForResource:@"ToDoData"
                                                                    ofType:@"plist"];
    NSArray* todoInitDataList = [[NSArray array] initWithContentsOfFile:todoInitDataFileStr];
    
    Action* initToDoAction = [[Action alloc] initWithReduxActionType:ReduxActionTypeQueryAllToDo
                                                              params:todoInitDataList];
    [[Store sharedInstance] dispatchWithAction:initToDoAction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
