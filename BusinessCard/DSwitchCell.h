//
//  DSwitchCell.h
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 29/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSwitchCellDelegate;

@interface DSwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *theSwitch;
@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) id <DSwitchCellDelegate> delegate;

@end

@protocol DSwitchCellDelegate <NSObject>

- (void)switchCell:(DSwitchCell *)switchCell switchValueChanged:(UISwitch *)theSwitch;

@end
