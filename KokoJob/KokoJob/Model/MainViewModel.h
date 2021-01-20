//
//  MainViewModel.h
//  KokoJob
//
//  Created by Jason on 2021/1/20.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataModel.h"
#import "FriendModel.h"
#import "RequestList.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewModel : NSObject

@property (strong, nonatomic) UserDataModel *userModel;
@property (strong, nonatomic) NSMutableArray<FriendModel* > *friendModelList;

- (NSArray *)getCollectionType;
- (NSUInteger)numberOfSections;

@end

NS_ASSUME_NONNULL_END
