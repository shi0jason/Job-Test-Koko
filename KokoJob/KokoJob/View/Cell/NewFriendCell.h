//
//  NewFriendCell.h
//  KokoJob
//
//  Created by Jason on 2021/1/19.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface NewFriendCell : UICollectionViewCell

- (void)configure:(FriendModel *)model;

@end

NS_ASSUME_NONNULL_END
