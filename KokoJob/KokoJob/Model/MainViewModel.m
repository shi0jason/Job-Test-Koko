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
        if (model.status == 2) {
            [inviteList addObject: model];
        } else {
            [existFriendList addObject: model];
        }
    }
    if (_userModel) {
        [self.cotentList addObject: _userModel];
    }
    [self.cotentList addObjectsFromArray: inviteList];
    [self.cotentList addObject: tabSwitchCell];
    [self.cotentList addObject: dataState == ProxyNoFriendAndInviteState ? noneFriendCell : searchCell];
    [self.cotentList addObjectsFromArray: existFriendList];
}

- (NSArray *)getCollectionType {
    return self.cotentList.copy;
}

- (NSUInteger)numberOfSections {
    return self.cotentList.count;
}

@end
