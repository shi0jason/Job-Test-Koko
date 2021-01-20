//
//  MainViewModel.m
//  KokoJob
//
//  Created by 施崇邑 on 2021/1/20.
//  Copyright © 2021 施崇邑. All rights reserved.
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
    
    for (FriendModel *model in self.friendModelList) {
        if (model.status == 0) {
            
        }
    }
}

- (int)numberOfSections {
    switch (dataState) {
        case ProxyNoFriendAndInviteState:
//            NSArray *list = @[userCell, tabSwitchCell, noneFriendCell];
            return 0;
        case ProxyHaveFriendAndNOInviteState:
//            NSArray *list = @[userCell, tabSwitchCell, searchCell];
            return 0;
        case ProxyHaveFriendAndInviteState:
//            NSArray *list = @[userCell, tabSwitchCell, searchCell];
            return 0;
        default:
            return 0;
    }
}

@end
