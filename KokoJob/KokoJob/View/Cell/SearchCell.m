//
//  SearchCell.m
//  KokoJob
//
//  Created by Jason on 2021/1/19.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "SearchCell.h"

@interface SearchCell() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.inputTextField.delegate = self;
}

- (IBAction)searchAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(search:)]) {
        [self.delegate search: self.inputTextField.text];
    }
}

@end
