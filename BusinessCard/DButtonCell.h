//
//  DButtonCell.h
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 15/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DButtonCellDelegate;

@interface DButtonCell : UITableViewCell

@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UILabel *titleLbl;
@property (strong, nonatomic) UILabel *statusLbl;
@property (strong, nonatomic) UILabel *lastLoginLbl;

@property (weak, nonatomic) id <DButtonCellDelegate> delegate;

- (void)setSignInConfiguration;
- (void)setSignOutConfiguration;

@end

@protocol DButtonCellDelegate <NSObject>

- (void)buttonCell:(DButtonCell *)pickerCell didTapButton:(UIButton *)button;

@end

