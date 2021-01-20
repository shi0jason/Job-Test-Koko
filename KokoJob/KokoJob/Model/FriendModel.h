//
//  FriendModel.h
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) int status;
@property (strong, nonatomic) NSString *isTop;
@property (strong, nonatomic) NSString *fid;
@property (strong, nonatomic) NSString *updateDate;

@end

NS_ASSUME_NONNULL_END
