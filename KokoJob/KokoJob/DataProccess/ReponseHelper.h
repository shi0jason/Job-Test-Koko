//
//  ReponseHelper.h
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataModel.h"
#import "FriendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReponseHelper : NSObject

+ (nullable id)processDataWith:(NSDictionary* )dict;

@end

NS_ASSUME_NONNULL_END
