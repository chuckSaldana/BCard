//
//  DSwitchCell.m
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 29/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "DSwitchCell.h"

@implementation DSwitchCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)switchTapped:(id)sender {
    [self.delegate switchCell:self switchValueChanged:sender];
}

@end
