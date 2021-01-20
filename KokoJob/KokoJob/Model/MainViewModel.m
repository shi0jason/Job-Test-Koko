//
//  MainViewModel.m
//  KokoJob
//
//  Created by 施崇邑 on 2021/1/20.
//  Copyright © 2021 施崇邑. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel

- (int)numberOfSections {
    switch (dataState) {
        case ProxyNoFriendAndInviteState:
//            @[]
            return 0;
            break;
        case ProxyHaveFriendAndNOInviteState:
            return 0;
            break;
        case ProxyHaveFriendAndInviteState:
            return 0;
            break;
        default:
            return 0;
    }
}

@end
