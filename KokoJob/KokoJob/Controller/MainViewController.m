//
//  MainViewController.m
//  KokoJob
//
//  Created by Jason on 2021/1/14.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    UICollectionView *collectionView;
}
@end

@implementation MainViewController

#define cellIdentifer @"Cell"
#define userCell @"userCell"
#define noneFriendCell @"noneFriendCell"
#define tabSwitchCell @"tabSwitchCell"
#define searchCell @"searchCell"
#define newFriendCell @"newFriendCell"
#define existFriendCell @"existFriendCell"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed: 250.0 / 255.0
                                                green: 250.0 / 255.0
                                                 blue: 250.0 / 255.0
                                                alpha: 1.0];
    [self setupCollectionView];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                        collectionViewLayout:layout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [collectionView registerClass: [UICollectionViewCell class]
       forCellWithReuseIdentifier: cellIdentifer];

    [collectionView registerNib: [UINib nibWithNibName: userCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: userCell];
    [collectionView registerNib: [UINib nibWithNibName: noneFriendCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: noneFriendCell];
    [collectionView registerNib: [UINib nibWithNibName: tabSwitchCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: tabSwitchCell];
    [collectionView registerNib: [UINib nibWithNibName: searchCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: searchCell];
    [collectionView registerNib: [UINib nibWithNibName: newFriendCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: newFriendCell];
    [collectionView registerNib: [UINib nibWithNibName: existFriendCell bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: existFriendCell];
    
    [collectionView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:collectionView];
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
