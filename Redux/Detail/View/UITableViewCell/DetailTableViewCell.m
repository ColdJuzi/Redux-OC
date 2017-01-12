//
//  DetailTableViewCell.m
//  Redux
//
//  Created by LiangHao on 11/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Header
- (void)drawTodoCurrentState:(ToDoState)todoState {
    NSString* subTitleStr = nil;
    UIColor* subTitleColor = nil;
    switch (todoState) {
        case ToDoStateNew: {
            subTitleStr = @"New";
            subTitleColor = [UIColor blueColor];
        }
            break;
        case ToDoStateDoing: {
            subTitleStr = @"Doing";
            subTitleColor = [UIColor orangeColor];
        }
            break;
        case ToDoStateFinish: {
            subTitleStr = @"Finish";
            subTitleColor = [UIColor greenColor];
        }
            break;
        case ToDoStateDelete: {
            subTitleStr = @"Delete";
            subTitleColor = [UIColor redColor];
        }
            break;
        default:
            break;
    }
    self.detailTextLabel.text = subTitleStr;
    self.detailTextLabel.textColor = subTitleColor;
}

@end
