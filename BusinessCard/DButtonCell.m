//
//  DButtonCell.m
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 15/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "DButtonCell.h"

@interface DButtonCell ()

@property (strong, nonatomic) UIView *container;

@end

@implementation DButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        
        self.titleLbl = [[UILabel alloc] init];
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonTapped:(id)sender {
    [self.delegate buttonCell:self didTapButton:sender];
}

- (void)setSignInConfiguration {
    [self.container removeFromSuperview];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 280)];
    container.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    self.button.frame = CGRectMake(25, 25, 270, 50);
    [container addSubview:self.button];
    
    self.titleLbl.font = [UIFont boldSystemFontOfSize:18];
    self.titleLbl.textColor = [UIColor whiteColor];
    self.titleLbl.frame = CGRectMake(70, 42, 180, 20);
    [container addSubview:self.titleLbl];
    
    [self.contentView addSubview:container];
    
    self.button.backgroundColor = UIColorFromRGB(0x1dbd9c);
}

- (void)setSignOutConfiguration {
    [self.container removeFromSuperview];
    
    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 280)];
    self.container.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    self.statusLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 20)];
    self.lastLoginLbl = [[UILabel alloc] initWithFrame:CGRectMake(62, 50, 200, 18)];
    
    [self.container addSubview:self.statusLbl];
    [self.container addSubview:self.lastLoginLbl];
    
    self.button.frame = CGRectMake(25, 90, 270, 50);
    [self.container addSubview:self.button];
    
    self.titleLbl.font = [UIFont boldSystemFontOfSize:18];
    self.titleLbl.textColor = [UIColor whiteColor];
    self.titleLbl.frame = CGRectMake(115, 105, 90, 20);
    [self.container addSubview:self.titleLbl];
    
    [self.contentView addSubview:self.container];
    
    self.statusLbl.textColor = UIColorFromRGB(0x1dbd9c);
    self.statusLbl.font = [UIFont boldSystemFontOfSize:16];
    self.lastLoginLbl.textColor = UIColorFromRGB(0x888888);
    self.lastLoginLbl.font = [UIFont boldSystemFontOfSize:12];
    
    self.button.backgroundColor = UIColorFromRGB(0x2d3035);
    self.statusLbl.text = @"You're currently signed-in";
}

@end
