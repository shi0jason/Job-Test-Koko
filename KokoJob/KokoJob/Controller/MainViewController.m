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
    
    self.view.backgroundColor = [UIColor colorWithRed: 250.0 / 255.0
                                                green: 250.0 / 255.0
                                                 blue: 250.0 / 255.0
                                                alpha: 1.0];
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

    [self.collectionView registerClass: [UserCell class] forCellWithReuseIdentifier: userCell];
    [self.collectionView registerClass: [NoneFriendCell class] forCellWithReuseIdentifier: noneFriendCell];
    [self.collectionView registerClass: [TabSwitchCell class] forCellWithReuseIdentifier: tabSwitchCell];
    [self.collectionView registerClass: [SearchCell class] forCellWithReuseIdentifier: searchCell];
    [self.collectionView registerClass: [NewFriendCell class] forCellWithReuseIdentifier: newFriendCell];
    [self.collectionView registerClass: [ExistFriendCell class] forCellWithReuseIdentifier: existFriendCell];
    
    [self.collectionView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview: self.collectionView];
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
        if ([object isEqualToString: userCell]) {
            UserCell *cell = (UserCell *)[collectionView dequeueReusableCellWithReuseIdentifier: userCell forIndexPath:indexPath];
            return cell;
        } else if ([object isEqualToString: noneFriendCell]) {
            NoneFriendCell *cell = (NoneFriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier: noneFriendCell forIndexPath:indexPath];
            return cell;
        } else if ([object isEqualToString: tabSwitchCell]) {
            TabSwitchCell *cell = (TabSwitchCell *)[collectionView dequeueReusableCellWithReuseIdentifier: tabSwitchCell forIndexPath:indexPath];
            return cell;
        } else if ([object isEqualToString: searchCell]) {
            SearchCell *cell = (SearchCell *)[collectionView dequeueReusableCellWithReuseIdentifier: searchCell forIndexPath:indexPath];
            return cell;
        }
    } else if ([object isKindOfClass:[FriendModel class]]) {
        FriendModel *model = object;
        if (model.status == 0) {
            NewFriendCell *cell = (NewFriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier: newFriendCell forIndexPath:indexPath];
            return cell;
        } else if (model.status == 1) {
            ExistFriendCell *cell = (ExistFriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier: existFriendCell forIndexPath:indexPath];
            return cell;
        }
        
    }
//        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifer
//                                                                               forIndexPath: indexPath];
//
//        return cell;
    return [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifer
                                                     forIndexPath: indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*) collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *) indexPath {
    return CGSizeMake(self.view.frame.size.width, 50);
}
@end
