//
//  DownloadProxy.m
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "DownloadProxy.h"
#import "RequestList.h"
#import "ReponseHelper.h"
#import "UserDataModel.h"
#import "FriendModel.h"

@interface DownloadProxy()

@property (strong, nonatomic) dispatch_queue_t queue;
@property (strong, nonatomic) dispatch_group_t group;
@property (strong, nonatomic) MainViewModel *blockModel;

typedef void(^_Nullable completionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@end

@implementation DownloadProxy

+ (instancetype)shared {
    static DownloadProxy *proxy = nil;
    if(proxy == nil) {
        proxy = [[DownloadProxy alloc] init];
        proxy.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        proxy.group = dispatch_group_create();
    }
    return proxy;
}

- (void)fetchAllDataWithState:(DownloadProxyState)state handler:(void (^)(MainViewModel * _Nullable viewModel, NSError * _Nullable error))handler {
    switch (state) {
        case ProxyNoFriendAndInviteState:
            [self fetchProxyNoFriendAndInviteStateWithhandler: handler];
            break;
        case ProxyHaveFriendAndNOInviteState:
            [self fetchProxyHaveFriendAndNOInviteStateWithhandler: handler];
            break;
        case ProxyHaveFriendAndInviteState:
            [self fetchProxyHaveFriendAndInviteStateWithhandler: handler];
            break;
        default:
            break;
    }
}

- (void)fetchProxyNoFriendAndInviteStateWithhandler:(void (^)(MainViewModel * _Nullable viewModel, NSError * _Nullable error))handler {
    NSArray *requestList = @[userData, emptyData];
    [self fetchAllDataWith:requestList withhandler: handler];
}

- (void)fetchProxyHaveFriendAndNOInviteStateWithhandler:(void (^)(MainViewModel * _Nullable viewModel, NSError * _Nullable error))handler {
    NSArray *requestList = @[userData, friendList1, friendList2];
    [self fetchAllDataWith:requestList withhandler: handler];
}

- (void)fetchProxyHaveFriendAndInviteStateWithhandler:(void (^)(MainViewModel * _Nullable viewModel, NSError * _Nullable error))handler {
    NSArray *requestList = @[userData, friendList3];
    [self fetchAllDataWith:requestList withhandler: handler];
}

- (void)fetchAllDataWith:(NSArray *)list withhandler:(void (^)(MainViewModel * _Nullable viewModel, NSError * _Nullable error))handler {
    if (self.blockModel == nil) {
        self.blockModel = [[MainViewModel alloc] init];
    }
    if (self.blockModel.friendModelList == nil) {
        self.blockModel.friendModelList = @[].mutableCopy;
    }
    __weak typeof(self) weakSelf = self;
    for (NSString *path in list) {
        dispatch_group_enter(_group);
        [self sendRequest: path withCompletionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if(httpResponse.statusCode == 200) {
                NSError *parseError = nil;
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                   options:0
                                                                                     error:&parseError];
                id processObject = [ReponseHelper processDataWith: responseDictionary];
                if ([processObject isKindOfClass: [UserDataModel class]]) {
                    weakSelf.blockModel.userModel = (UserDataModel *)processObject;
                } else if ([processObject isKindOfClass: [NSMutableArray<FriendModel* > class]]) {
                    NSMutableArray<FriendModel* > *resultList = weakSelf.blockModel.friendModelList;
                    NSMutableArray<FriendModel* > *friendModelList = processObject;
                    
                    if (self.blockModel.friendModelList.count == 0 && friendModelList.count > 0) {
                        weakSelf.blockModel.friendModelList = processObject;
                        NSLog(@"The response is - %@",responseDictionary);
                        dispatch_group_leave(weakSelf.group);
                        return;
                    }

                    NSMutableArray *keyList = [[NSMutableArray alloc] initWithArray: resultList];
                    [keyList addObjectsFromArray: friendModelList];
                    
                    
                    
                    NSMutableArray *keyfilterList = @[].mutableCopy;
                    NSMutableArray *updatefilterList = @[].mutableCopy;
                    
                    if (self.blockModel.friendModelList.count > 0) {
                        for (FriendModel *model in keyList) {
                            if (![keyfilterList containsObject: model.name]) {
                                [keyfilterList addObject: model.name];
                                [updatefilterList addObject: model.updateDate];
                            } else if ([keyfilterList containsObject: model.name]) {
                                int index = [self getIndexWithArray: keyfilterList Model: model];
                                NSString *insideDate = updatefilterList[index];
                                if ([model.updateDate intValue] < [insideDate intValue]) {
                                    [resultList removeObjectAtIndex: index];
                                    [resultList addObject: model];
                                }
                            }
                        }
                    } else {
                        weakSelf.blockModel.friendModelList = processObject;
                    }
                    
                    for (FriendModel *model in resultList) {
                        if ([keyfilterList containsObject: model.name]) {
                            [keyfilterList removeObject: model.name];
                        }
                    }
                    for (NSString *name in keyfilterList) {
                        for (FriendModel *model in processObject) {
                            if ([name isEqualToString: model.name]) {
                                [resultList addObject: model];
                            }
                        }
                    }
                    weakSelf.blockModel.friendModelList = resultList;
                }
                NSLog(@"The response is - %@",responseDictionary);
                dispatch_group_leave(weakSelf.group);
            } else {
                NSLog(@"Error");
                dispatch_group_leave(weakSelf.group);
            }
        }];
    }
    dispatch_group_notify(_group, _queue, ^{
        handler(weakSelf.blockModel, nil);
    });
}

- (int)getIndexWithArray:(NSArray *)list  Model:(FriendModel *) model {
    for (int i = 0; i < list.count; i++) {
        NSString *name = list[i];
        if ([name isEqualToString: model.name]) {
            return i;
        }
    }
    return 0;
}

- (void)sendRequest:(NSString *)path withCompletionHandler:(completionHandler)completionHandler {
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: path]];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest
                                                completionHandler:^(NSData *data,
                                                                    NSURLResponse *response,
                                                                    NSError *error) {
        completionHandler(data, response, error);
    }];
    [dataTask resume];
}

@end
