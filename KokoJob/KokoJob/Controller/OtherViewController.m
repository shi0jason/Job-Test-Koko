//
//  OtherViewController.m
//  KokoJob
//
//  Created by Jason on 2021/1/18.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.selectedIndex = 1;
    self.view.backgroundColor = [UIColor colorWithRed: 250.0 / 255.0
                                                green: 250.0 / 255.0
                                                 blue: 250.0 / 255.0
                                                alpha: 1.0];
}

@end
