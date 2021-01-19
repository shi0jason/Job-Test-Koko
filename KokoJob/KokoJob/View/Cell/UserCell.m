//
//  UserCell.m
//  KokoJob
//
//  Created by 施崇邑 on 2021/1/19.
//  Copyright © 2021 施崇邑. All rights reserved.
//

#import "UserCell.h"

@interface UserCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userTitle;
@property (weak, nonatomic) IBOutlet UILabel *kokoIdLabel;
@property (weak, nonatomic) IBOutlet UIView *unknowView;

@end

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    self.unknowView.layer.cornerRadius = self.unknowView.frame.size.width / 2;
}

- (void)configure {

}

@end
