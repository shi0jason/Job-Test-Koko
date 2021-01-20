//
//  ExistFriendCell.m
//  KokoJob
//
//  Created by Jason on 2021/1/19.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "ExistFriendCell.h"

@interface ExistFriendCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UIButton *inviteButton;

@end

@implementation ExistFriendCell

- (void)configure:(FriendModel *)model {
    [self.nameLabel setText: model.name];
    [self.starImageView setHidden: [model.isTop isEqualToString: @"0"] ? true : false];
    if (model.status == 0) {
        [self.inviteButton setHidden: false];
    }
    if (model.status != 0) {
        [self.inviteButton setTitle: @"" forState: UIControlStateNormal];
        [self.inviteButton setImage: [[UIImage imageNamed: @"icFriendsMore"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]
                           forState: UIControlStateNormal];
//        [[UIImage imageNamed: imageString] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]
    }
}

- (IBAction)transterCoin:(id)sender {

}

- (IBAction)inviteAction:(id)sender {

}

@end
