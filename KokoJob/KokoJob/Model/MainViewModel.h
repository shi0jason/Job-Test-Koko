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

@protocol MainViewModelDelegate <NSObject>

- (void)reloadData;

@end

@interface MainViewModel : NSObject

@property (strong, nonatomic) UserDataModel *userModel;
@property (strong, nonatomic) NSMutableArray<FriendModel* > *friendModelList;
@property(weak, nonatomic) id<MainViewModelDelegate> delegate;

- (NSArray *)getCollectionType;
- (NSUInteger)numberOfSections;
- (void)search:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
