//
//  DownloadProxy.h
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestList.h"
#import "MainViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DownloadProxy : NSObject

+ (instancetype)shared;
- (void)fetchAllDataWithState:(DownloadProxyState)state handler:(void (^)(MainViewModel * _Nullable viewModel, NSError * _Nullable error))handler;

@end

NS_ASSUME_NONNULL_END
