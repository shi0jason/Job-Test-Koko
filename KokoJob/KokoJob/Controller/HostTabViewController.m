//
//  HostTabViewController.m
//  KokoJob
//
//  Created by Jason on 2021/1/17.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "HostTabViewController.h"
#import "OtherViewController.h"
#import "MainViewController.h"

@interface HostTabViewController () <UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *hostTabbar;

@end

@implementation HostTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabbarTopLine];
    [self setupTabbarItem];
}

- (void)setupTabbarTopLine {
    [UITabBar appearance].shadowImage = [UIImage new];
    [UITabBar appearance].backgroundImage = [UIImage new];
    [UITabBar appearance].backgroundColor = UIColor.whiteColor;
}

- (void)setupTabbarItem {
    NSMutableArray *vcList = @[].mutableCopy;
    NSArray *imageList = @[
                           @"icTabbarProductsOff",
                           @"icTabbarFriendsOn",
                           @"icTabbarHomeOff",
                           @"icTabbarManageOff",
                           @"icTabbarSettingOff"
                           ];
    for (int i = 0 ; i < imageList.count ; i++) {
        NSString *imageString = imageList[i];
        if ([imageString isEqualToString:@"icTabbarFriendsOn"]) {
            MainViewController *mainVC = [[MainViewController alloc] init];
            UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle: nil
                                                                  image: [[UIImage imageNamed: imageString] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]
                                                                    tag: i];
            mainVC.tabBarItem = barItem;
            UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController: mainVC];
            vc.modalPresentationStyle = UIModalPresentationNone;
            [vcList addObject: vc];
        } else {
            OtherViewController *otherVC = [[OtherViewController alloc] init];
            UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle: nil
                                                                  image: [[UIImage imageNamed: imageString] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]
                                                                    tag: i];
            otherVC.tabBarItem = barItem;
            UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController: otherVC];
            [vcList addObject: vc];
        }
    }
    self.viewControllers = vcList;
    self.delegate = self;
}

- (void)removeTitle {
    for (UITabBarItem *item in self.hostTabbar.items) {
        item.title = @"";
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(nonnull UIViewController *)viewController {
    NSLog(@"%lu", (unsigned long)self.selectedIndex);
}
@end
