//
//  MainViewModel.m
//  KokoJob
//
//  Created by Jason on 2021/1/20.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "MainViewModel.h"

@interface MainViewModel()

@property (strong, nonatomic) NSMutableArray *cotentList;

@end

@implementation MainViewModel

- (void)setFriendModelList:(NSMutableArray<FriendModel *> *)friendModelList {
    _friendModelList = friendModelList;
    
    NSMutableArray *prcessFriendModelList = friendModelList;
    
    NSMutableArray *inviteList = @[].mutableCopy;
    NSMutableArray *existFriendList = @[].mutableCopy;
    
    self.cotentList = @[].mutableCopy;
    
    for (FriendModel *model in prcessFriendModelList) {
        if (model.status == 0) {
            [inviteList addObject: model];
        } else {
            [existFriendList addObject: model];
        }
    }
    [self.cotentList addObject: userCell];
    [self.cotentList addObjectsFromArray: inviteList];
    [self.cotentList addObject: tabSwitchCell];
    [self.cotentList addObjectsFromArray: existFriendList];
    [self.cotentList addObject: dataState == ProxyNoFriendAndInviteState ? noneFriendCell : searchCell];
}

- (NSArray *)getCollectionType {
    return self.cotentList.copy;
}

- (NSUInteger)numberOfSections {
    return self.cotentList.count;
}

@end
