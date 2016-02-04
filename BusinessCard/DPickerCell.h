//
//  DPickerCell.h
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 14/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DPickerCellDelegate;

@interface DPickerCell : UITableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray *values;
@property (weak, nonatomic) id <DPickerCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end

@protocol DPickerCellDelegate <NSObject>

- (void)pickerCell:(DPickerCell *)pickerCell didSelectValue:(NSString *)value;

@end
