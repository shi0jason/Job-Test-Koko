//
//  SearchCell.h
//  KokoJob
//
//  Created by Jason on 2021/1/19.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SearchCellDelegate <NSObject>

- (void)search:(NSString *)text;

@end

@interface SearchCell : UICollectionViewCell

@property(weak, nonatomic) id<SearchCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
