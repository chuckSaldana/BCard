//
//  DDatePickerCell.h
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 14/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDatePickerCellMaxDate [NSDate dateWithTimeIntervalSinceNow: - (31557600 * 13)]   // 13 years in the past ...

@protocol DDatePickerCellDelegate;

@interface DDatePickerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) id <DDatePickerCellDelegate> delegate;

@end

@protocol DDatePickerCellDelegate <NSObject>

- (void)datePickerCell:(DDatePickerCell *)pickerCell didSelectDate:(NSDate *)value;

@end
