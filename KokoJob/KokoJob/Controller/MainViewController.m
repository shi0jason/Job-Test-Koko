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

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SearchCellDelegate, MainViewModelDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) MainViewModel *viewModel;
@property (strong, nonatomic) NSLayoutConstraint *collectionViewTopConstaint;
@property (strong, nonatomic) NSLayoutConstraint *collectionViewBottomConstaint;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

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
        weakSelf.viewModel.delegate = weakSelf;
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
    [self.collectionView.superview endEditing: true];
    [self.view addSubview: self.collectionView];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    self.collectionViewTopConstaint = [NSLayoutConstraint constraintWithItem: self.collectionView
                                                                   attribute: NSLayoutAttributeTop
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: self.view
                                                                   attribute: NSLayoutAttributeTop
                                                                  multiplier: 1.0 constant: 50.0];
    self.collectionViewBottomConstaint = [NSLayoutConstraint constraintWithItem: self.collectionView
                                                                      attribute: NSLayoutAttributeBottom
                                                                      relatedBy: NSLayoutRelationEqual
                                                                         toItem: self.view
                                                                      attribute: NSLayoutAttributeBottom
                                                                     multiplier: 1.0 constant: 0.0];
    [self.view addConstraints:@[
                                self.collectionViewTopConstaint,
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
                                self.collectionViewBottomConstaint
                                ]];
}
#pragma mark - Keyboard Action

- (void)keyboardDidHide:(NSNotification *) notification {
    self.collectionViewTopConstaint.constant = 0;
    self.collectionViewBottomConstaint.constant = 0;
}

- (void)keyboardWillChangeFrame:(NSNotification *) notification {
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.collectionViewTopConstaint.constant = -keyboardHeight + 50;
    self.collectionViewBottomConstaint.constant = -keyboardHeight + 50;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded: touches withEvent: event];
    [self.view endEditing: true];
}

#pragma mark - Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing: true];
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
            cell.delegate = self;
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

- (void)search:(NSString *)text {
    if (self.viewModel) {
        [self.viewModel search: text];
    }
}

- (void)reloadData {
    [self.collectionView reloadData];
}

@end
