//
//  JSONModel+Assign.m
//  PhantomSteward
//
//  Created by LiangHao on 07/12/2016.
//  Copyright © 2016 PhantomSmart. All rights reserved.
//

#import "JSONModel+Assign.h"

@implementation JSONModel (Assign)

+ (JSONModel *)objectAssignWithOldItem:(JSONModel *)model changeInfo:(NSDictionary *)changeDict {
    NSMutableDictionary* oldModelDict = [[NSMutableDictionary alloc] initWithDictionary:[model toDictionary]];
    [oldModelDict setValuesForKeysWithDictionary:changeDict];
    return [[[(JSONModel *)model class] alloc] initWithDictionary:oldModelDict error:nil];
}

+ (JSONModel *)objectAssignWithOldItem:(JSONModel *)model updateItem:(JSONModel *)changeItem {
    NSMutableDictionary* oldModelDict = [[NSMutableDictionary alloc] initWithDictionary:[model toDictionary]];
    [oldModelDict setValuesForKeysWithDictionary:[changeItem toDictionary]];
    return [[[(JSONModel *)model class] alloc] initWithDictionary:oldModelDict error:nil];
}

@end
