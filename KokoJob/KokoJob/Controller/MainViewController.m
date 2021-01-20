//
//  MainViewController.m
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "MainViewController.h"
#import "DownloadProxy.h"

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
    
    [self.collectionView registerClass: [UICollectionViewCell class]
       forCellWithReuseIdentifier: cellIdentifer];

    [self.collectionView registerNib: [UINib nibWithNibName: userCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: userCell];
    [self.collectionView registerNib: [UINib nibWithNibName: noneFriendCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: noneFriendCell];
    [self.collectionView registerNib: [UINib nibWithNibName: tabSwitchCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: tabSwitchCell];
    [self.collectionView registerNib: [UINib nibWithNibName: searchCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: searchCell];
    [self.collectionView registerNib: [UINib nibWithNibName: newFriendCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: newFriendCell];
    [self.collectionView registerNib: [UINib nibWithNibName: existFriendCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: existFriendCell];
    
    [self.collectionView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview: self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *) collectionView
     numberOfItemsInSection:(NSInteger) section {
    return 15;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *) collectionView
                  cellForItemAtIndexPath:(NSIndexPath *) indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifer
                                                                           forIndexPath: indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*) collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *) indexPath {
    return CGSizeMake(self.view.frame.size.width, 50);
}
@end
