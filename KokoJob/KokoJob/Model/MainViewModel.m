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
@property (strong, nonatomic) NSMutableArray *searchList;
@property (strong, nonatomic) NSMutableArray *compareList;

@end

@implementation MainViewModel

- (void)setFriendModelList:(NSMutableArray<FriendModel *> *)friendModelList {
    _friendModelList = friendModelList;
    
    NSMutableArray *prcessFriendModelList = friendModelList;
    
    NSMutableArray *inviteList = @[].mutableCopy;
    NSMutableArray *existFriendList = @[].mutableCopy;
    
    self.cotentList = @[].mutableCopy;
    self.searchList = @[].mutableCopy;
    self.compareList = @[].mutableCopy;
    
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
    self.compareList = existFriendList;
    
    NSArray *cotentList = self.cotentList;
    self.searchList = cotentList.mutableCopy;
}

- (NSArray *)getCollectionType {
    if (self.searchList.count != self.cotentList.count) {
        return self.searchList;
    }
    return self.cotentList.copy;
}

- (NSUInteger)numberOfSections {
    if (self.searchList.count != self.cotentList.count) {
        return self.searchList.count;
    }
    return self.cotentList.count;
}

- (void)search:(NSString *)text {
    if (text.length == 0) {
        self.searchList = self.cotentList;
        if (self.delegate && [self.delegate respondsToSelector:@selector(reloadData)]) {
            [self.delegate reloadData];
        }
        return;
    }
    NSMutableArray *existFriendList = [[NSMutableArray alloc] init];
    NSMutableArray *cotentList = [[NSMutableArray alloc] init];
    [existFriendList addObjectsFromArray: self.compareList];
    for (id object in self.cotentList) {
        if ([object isKindOfClass: [FriendModel class]]) {
            FriendModel *model = object;
            if (model.status != 2) {
                break;
            }
        }
        [cotentList addObject: object];
    }
    
    [existFriendList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(FriendModel *model, NSUInteger index, BOOL *stop) {
        if (![model.name containsString: text]) {
            [existFriendList removeObjectAtIndex:index];
        }
    }];

    [cotentList addObjectsFromArray:existFriendList];
    self.searchList = cotentList;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadData)]) {
        [self.delegate reloadData];
    }
}

@end
