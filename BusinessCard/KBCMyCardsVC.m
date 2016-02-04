//
//  KBCMyCardsVC.m
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 26/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "KBCMyCardsVC.h"
#import "KBCCardVC.h"
#import "KBCCardCollectionCell.h"

@interface KBCMyCardsVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionFlowLayout;
@property (strong, nonatomic) NSArray *cards;

@end

@implementation KBCMyCardsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)showMenu:(id)sender {
    [MainSidePanel showLeftPanelAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.cards = @[[[KBCCardVC alloc] initWithOrientation:kCardOrientationLandscape],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationPortrait],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationPortrait],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationLandscape],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationLandscape],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationLandscape],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationLandscape],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationPortrait],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationPortrait],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationPortrait],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationPortrait],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationLandscape],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationPortrait],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationLandscape],
                   [[KBCCardVC alloc] initWithOrientation:kCardOrientationPortrait]
                   ];
    self.collectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = self.collectionFlowLayout;
    [self.collectionView registerClass:[KBCCardCollectionCell class] forCellWithReuseIdentifier:@"cellID"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.cards count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KBCCardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    KBCCardVC *aCard = self.cards[indexPath.row];
    // 2
    CGSize retval = aCard.orientation == kCardOrientationPortrait ? CGSizeMake(100, 180) : CGSizeMake(180, 100);
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 10, 15, 10);
}

@end
