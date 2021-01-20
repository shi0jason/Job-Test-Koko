//
//  MainViewController.m
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "MainViewController.h"
#import "DownloadProxy.h"
#import "UserCell.h"
#import "NoneFriendCell.h"
#import "TabSwitchCell.h"
#import "SearchCell.h"
#import "NewFriendCell.h"
#import "ExistFriendCell.h"

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) MainViewModel *viewModel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCollectionView];
    [self fetchData];
}

- (void)fetchData { // ProxyNoFriendAndInviteState
    __weak typeof(self) weakSelf = self;
    [DownloadProxy.shared fetchAllDataWithState: dataState handler:^(MainViewModel * _Nullable viewModel, NSError * _Nullable error) {
        weakSelf.viewModel = viewModel;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    }];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                        collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass: [UICollectionViewCell class] forCellWithReuseIdentifier: cellIdentifer];

    [self.collectionView registerNib: [UINib nibWithNibName: userCell bundle: nil] forCellWithReuseIdentifier: userCell];
    [self.collectionView registerNib: [UINib nibWithNibName: noneFriendCell bundle: nil] forCellWithReuseIdentifier: noneFriendCell];
    [self.collectionView registerNib: [UINib nibWithNibName: tabSwitchCell bundle: nil] forCellWithReuseIdentifier: tabSwitchCell];
    [self.collectionView registerNib: [UINib nibWithNibName: searchCell bundle: nil] forCellWithReuseIdentifier: searchCell];
    [self.collectionView registerNib: [UINib nibWithNibName: newFriendCell bundle: nil] forCellWithReuseIdentifier: newFriendCell];
    [self.collectionView registerNib: [UINib nibWithNibName: existFriendCell bundle: nil] forCellWithReuseIdentifier: existFriendCell];
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview: self.collectionView];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem: self.collectionView
                                                             attribute: NSLayoutAttributeTop
                                                             relatedBy: NSLayoutRelationEqual
                                                                toItem: self.view
                                                             attribute: NSLayoutAttributeTop
                                                            multiplier: 1.0 constant: 50.0],
                                [NSLayoutConstraint constraintWithItem: self.collectionView
                                                             attribute: NSLayoutAttributeRight
                                                             relatedBy: NSLayoutRelationEqual
                                                                toItem: self.view
                                                             attribute: NSLayoutAttributeRight
                                                            multiplier: 1.0 constant: 0.0],
                                [NSLayoutConstraint constraintWithItem: self.collectionView
                                                             attribute: NSLayoutAttributeLeft
                                                             relatedBy: NSLayoutRelationEqual
                                                                toItem: self.view
                                                             attribute: NSLayoutAttributeLeft
                                                            multiplier: 1.0 constant: 0.0],
                                [NSLayoutConstraint constraintWithItem: self.collectionView
                                                             attribute: NSLayoutAttributeBottom
                                                             relatedBy: NSLayoutRelationEqual
                                                                toItem: self.view
                                                             attribute: NSLayoutAttributeBottom
                                                            multiplier: 1.0 constant: 0.0],
                                ]];
}

- (NSInteger)collectionView:(UICollectionView *) collectionView
     numberOfItemsInSection:(NSInteger) section {
    return self.viewModel.numberOfSections;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *) collectionView
                  cellForItemAtIndexPath:(NSIndexPath *) indexPath {
    id object = self.viewModel.getCollectionType[indexPath.item];
    if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString: noneFriendCell]) {
            NoneFriendCell *cell = (NoneFriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier: noneFriendCell forIndexPath:indexPath];
            return cell;
        } else if ([object isEqualToString: tabSwitchCell]) {
            TabSwitchCell *cell = (TabSwitchCell *)[collectionView dequeueReusableCellWithReuseIdentifier: tabSwitchCell forIndexPath:indexPath];
            return cell;
        } else if ([object isEqualToString: searchCell]) {
            SearchCell *cell = (SearchCell *)[collectionView dequeueReusableCellWithReuseIdentifier: searchCell forIndexPath:indexPath];
            return cell;
        }
    } else if ([object isKindOfClass:[UserDataModel class]]) {
        UserDataModel *model = object;
        UserCell *cell = (UserCell *)[collectionView dequeueReusableCellWithReuseIdentifier: userCell forIndexPath:indexPath];
        [cell configure: model];
        return cell;
    } else if ([object isKindOfClass:[FriendModel class]]) {
        FriendModel *model = object;
        if (model.status == 2) {
            NewFriendCell *cell = (NewFriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier: newFriendCell forIndexPath:indexPath];
            [cell configure: model];
            return cell;
        } else if (model.status == 0 || model.status == 1) {
            ExistFriendCell *cell = (ExistFriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier: existFriendCell forIndexPath:indexPath];
            [cell configure: model];
            return cell;
        }
    }
    return [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifer forIndexPath: indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*) collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *) indexPath {
    id object = self.viewModel.getCollectionType[indexPath.item];
    if ([object isKindOfClass:[NSString class]] && [object isEqualToString: tabSwitchCell]) {
        return CGSizeMake(self.view.frame.size.width, 30);
    }
    if ([object isKindOfClass:[NSString class]] && [object isEqualToString: noneFriendCell]) {
        return CGSizeMake(self.view.frame.size.width, 350);
    }
    return CGSizeMake(self.view.frame.size.width, 50);
}
@end
