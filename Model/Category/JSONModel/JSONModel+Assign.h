//
//  JSONModel+Assign.h
//  PhantomSteward
//
//  Created by LiangHao on 07/12/2016.
//  Copyright © 2016 PhantomSmart. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONModel (Assign)

+ (JSONModel *)objectAssignWithOldItem:(JSONModel *)model changeInfo:(NSDictionary *)changeDict;

+ (JSONModel *)objectAssignWithOldItem:(JSONModel *)model updateItem:(JSONModel *)changeItem;

@end
