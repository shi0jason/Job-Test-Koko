//
//  BaseViewController.m
//  KokoJob
//
//  Created by Jason on 2021/1/19.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBarItem];
}

- (void)setupNavigationBarItem {
    self.navigationController.navigationBar.topItem.leftBarButtonItems = @[
                                                                           [self customBarButtonItem: @"icNavPinkWithdraw"],
                                                                           [self customBarButtonItem: @"icNavPinkTransfer"]
                                                                           ];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = [self customBarButtonItem: @"icNavPinkScan"];
}

- (UIBarButtonItem *)customBarButtonItem:(NSString *) imageName {
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage: [[UIImage imageNamed: imageName] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]
                                                            style: UIBarButtonItemStylePlain
                                                           target: self
                                                           action: @selector(navigationAction:)];
    return btn;
}

- (void)navigationAction:(id)sender {
    NSLog(@"click");
}

@end
