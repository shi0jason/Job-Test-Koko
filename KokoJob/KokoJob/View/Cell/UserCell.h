//
//  UserCell.h
//  KokoJob
//
//  Created by Jason on 2021/1/19.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserCell : UICollectionViewCell

- (void)configure:(UserDataModel *)model;

@end

NS_ASSUME_NONNULL_END
