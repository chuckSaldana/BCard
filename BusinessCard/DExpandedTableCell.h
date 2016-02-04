//
//  DExpandedTableCell.h
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 08/05/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DTableCellDelegate;

@interface DExpandedTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLlb;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) id <DTableCellDelegate> delegate;
@property CGFloat cellHeight;

- (void)displayCoupons:(NSArray *)coupons;

@end

@protocol DTableCellDelegate <NSObject>

- (void)tableCell:(DExpandedTableCell *)aTableCell couponAtIndexDidChanceState:(int)index;

@end