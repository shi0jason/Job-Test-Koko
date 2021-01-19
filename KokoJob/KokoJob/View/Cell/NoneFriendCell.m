//
//  NoneFriendCell.m
//  KokoJob
//
//  Created by 施崇邑 on 2021/1/19.
//  Copyright © 2021 施崇邑. All rights reserved.
//

#import "NoneFriendCell.h"
@interface NoneFriendCell()

@property (weak, nonatomic) IBOutlet UIButton *addFriendButton;
@property (weak, nonatomic) IBOutlet UILabel *kokoIdLabel;

@end
@implementation NoneFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    [self createGradientLayer];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: @"幫助好友更快找到你？設定 KOKO ID"
                                                                                         attributes: @{
                                                                                                       NSFontAttributeName: [UIFont fontWithName: @"PingFangTC-Regular" size: 13.0],
                                                                                                       NSForegroundColorAttributeName: UIColor.brownColor,
                                                                                                       NSKernAttributeName: @0.0
                                                                                                             }];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value: [[UIColor alloc] initWithRed: 236.0 / 255.0
                                                           green: 0.0 / 255.0
                                                            blue: 140.0 / 255.0 alpha: 1.0]
                             range: NSMakeRange(10, 10)];

    self.kokoIdLabel.attributedText = attributedString;
}

- (void)createGradientLayer {
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = self.addFriendButton.bounds;
    gradientLayer.colors = @[
                             [[UIColor alloc] initWithRed: 86.0 / 255.0
                                                    green: 179.0 / 255.0
                                                     blue: 11.0 / 255.0 alpha: 1.0],
                             [[UIColor alloc] initWithRed: 166.0 / 255.0
                                                    green: 204.0 / 255.0
                                                     blue: 66.0 / 255.0 alpha: 1.0]
                             ];
    [self.addFriendButton.layer addSublayer: gradientLayer];
}
- (IBAction)addFriend:(id)sender {
    
}

@end
