//
//  ReponseHelper.m
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "ReponseHelper.h"

@implementation ReponseHelper


+ (nullable id)processDataWith:(NSDictionary* )dict {
    if ([dict.allKeys containsObject: @"response"]) {
        NSArray *response = dict[@"response"];
        if (response.count == 0) {
            return @[].mutableCopy;
        }
        NSDictionary *container = response[0];
        if ([container.allKeys containsObject: @"kokoid"]) {
            UserDataModel *model = [[UserDataModel alloc] init];
            model.name = container[@"name"];
            model.identifier = container[@"kokoid"];
            return model;
        } else {
            NSMutableArray *container = @[].mutableCopy;
            for (NSDictionary *dictInside in response) {
                FriendModel *model = [[FriendModel alloc] init];
                model.name = dictInside[@"name"];
                model.status = [dictInside[@"status"] intValue];
                model.isTop = dictInside[@"isTop"];
                model.fid = dictInside[@"fid"];
                model.updateDate = dictInside[@"updateDate"];
                [container addObject: model];
            }
            return container;
        }
    } else {
        return nil;
    }
}

@end
