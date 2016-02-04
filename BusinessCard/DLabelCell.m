//
//  DLabelCell.m
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 23/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "DLabelCell.h"

@implementation DLabelCell

- (void)awakeFromNib
{
    // Initialization code
    self.label.textColor = UIColorFromRGB(0x000000);
    self.label.font = [UIFont boldSystemFontOfSize:16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
