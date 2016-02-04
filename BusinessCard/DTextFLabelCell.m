//
//  DTextFLabelCell.m
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 30/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "DTextFLabelCell.h"

@interface DTextFLabelCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageV;

@end

@implementation DTextFLabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
