//
//  UITableViewCell+CellLineLeftMargin.m
//  PhantomSmart
//
//  Created by LiangHao on 15/10/28.
//  Copyright © 2015年 PhantomSmart. All rights reserved.
//

#import "UITableViewCell+CellLineLeftMargin.h"

@implementation UITableViewCell (CellLineLeftMargin)

//  Fix TableViewCell line left that the separator inset is set to the default of 15 on the right.  >= iOS 8
//  Stackoverflow Url : http://stackoverflow.com/a/25877725/1677041
-(void)setLayoutMarginsZero {
    // Remove seperator inset
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
