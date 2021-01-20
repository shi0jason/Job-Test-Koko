//
//  RequestList.h
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef RequestList_h
#define RequestList_h

static NSString *userData = @"https://dimanyen.github.io/man.json";
static NSString *friendList1 = @"https://dimanyen.github.io/friend1.json";
static NSString *friendList2 = @"https://dimanyen.github.io/friend2.json";
static NSString *friendList3 = @"https://dimanyen.github.io/friend3.json";
static NSString *emptyData = @"https://dimanyen.github.io/friend4.json";

#define cellIdentifer @"Cell"
#define userCell @"userCell"
#define noneFriendCell @"noneFriendCell"
#define tabSwitchCell @"tabSwitchCell"
#define searchCell @"searchCell"
#define newFriendCell @"newFriendCell"
#define existFriendCell @"existFriendCell"

typedef NS_ENUM(NSUInteger, DownloadProxyState) {
    ProxyNoFriendAndInviteState = 0,
    ProxyHaveFriendAndNOInviteState,
    ProxyHaveFriendAndInviteState
};
#define dataState ProxyNoFriendAndInviteState

#endif /* RequestList_h */
