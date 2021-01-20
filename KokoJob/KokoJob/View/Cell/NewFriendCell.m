//
//  NewFriendCell.m
//  KokoJob
//
//  Created by Jason on 2021/1/19.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "NewFriendCell.h"

@interface NewFriendCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation NewFriendCell

- (void)configure:(FriendModel *)model {
    [self.nameLabel setText: model.name];
}

- (IBAction)agreeAction:(id)sender {

}

- (IBAction)deleteAction:(id)sender {

}

@end
