//
//  MainViewModel.h
//  KokoJob
//
//  Created by 施崇邑 on 2021/1/20.
//  Copyright © 2021 施崇邑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataModel.h"
#import "FriendModel.h"
#import "RequestList.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewModel : NSObject

@property (strong, nonatomic) UserDataModel *userModel;
@property (strong, nonatomic) NSMutableArray<FriendModel* > *friendModelList;

@end

NS_ASSUME_NONNULL_END
