//
//  DetailTableViewCell.h
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoState.h"

@interface DetailTableViewCell : UITableViewCell

- (void)drawTodoCurrentState:(ToDoState)todoState;

@end
