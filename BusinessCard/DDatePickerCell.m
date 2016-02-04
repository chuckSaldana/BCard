//
//  DDatePickerCell.m
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 14/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "DDatePickerCell.h"

@implementation DDatePickerCell

- (void)awakeFromNib
{
    // Initialization code
    self.datePicker.maximumDate = kDatePickerCellMaxDate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)dateSelectedChanged:(id)sender {
    [self.delegate datePickerCell:self didSelectDate:self.datePicker.date];
}

@end
