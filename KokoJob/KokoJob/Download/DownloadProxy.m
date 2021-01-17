//
//  DownloadProxy.m
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "DownloadProxy.h"
#import "RequestList.h"

@implementation DownloadProxy

+ (instancetype)shared {
    static DownloadProxy *proxy = nil;
    if(proxy == nil) {
        proxy = [[DownloadProxy alloc] init];
    }
    return proxy;
}

- (void)fetchAllData {
    NSArray *requestList = @[userData, friendList1, friendList2, friendList3, friendList4];
    for (int i = 0; i < requestList.count; i++) {
        [self sendRequest: userData];
    }
}

- (void)fetchUserData {
    
}

- (void)fetchFriendListOne {
    
}

- (void)fetchFriendListTwo {
    
}

- (void)fetchFriendListThree {
    
}

- (void)fetchFriendListWithNoneData {
    
}


- (void)sendRequest:(NSString *)path {
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: path]];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if(httpResponse.statusCode == 200) {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:0
                                                                                 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

@end
