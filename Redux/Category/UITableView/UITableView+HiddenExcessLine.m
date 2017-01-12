//
//  UITableView+HiddenExcessLine.m
//  PhantomSmart
//
//  Created by LiangHao on 15/10/28.
//  Copyright © 2015年 PhantomSmart. All rights reserved.
//

#import "UITableView+HiddenExcessLine.h"

@implementation UITableView (HiddenExcessLine)

- (void)setExtraCellLineHidden {
    UIView* lineView =[ [UIView alloc]init];
    lineView.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:lineView];
}


@end
