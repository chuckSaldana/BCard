//
//  DTableCell.m
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 01/05/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "DSubcategoryCell.h"
#import "DFavoritesCell.h"

#define kSpinnerTag 3345

@interface DSubcategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *separationView;

@end

@implementation DSubcategoryCell

- (void)addSpinner {
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y);
    activityView.tag = kSpinnerTag;
    [activityView startAnimating];
    
    [self.contentView addSubview:activityView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
