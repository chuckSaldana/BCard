//
//  DExpandedTableCell.m
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 08/05/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "DExpandedTableCell.h"

#define kButtonTagOffset 984

@interface DExpandedTableCell ()

@end

@implementation DExpandedTableCell

- (void)awakeFromNib {
    
}

- (void)displayCoupons:(NSArray *)coupons {
    UIView *tableView = [[UIView alloc] initWithFrame:CGRectMake(50,
                                                                 CGRectGetMaxY(self.titleLlb.frame) + 10,
                                                                 self.frame.size.width - 50,
                                                                 [coupons count] * self.cellHeight)];
    tableView.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    CGFloat currY = 3;
    
    for (int i = 0; i < [coupons count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, currY, self.frame.size.width - 20, self.cellHeight);
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:button.frame];
        textLabel.text = coupons[i][@"coupon_name"];
        
        if ([coupons[i][@"selected"] boolValue]) {
            
            textLabel.textColor = self.titleLlb.textColor;
            
            UIImageView *indicator = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 45, textLabel.frame.origin.y, 25, 25)];
            indicator.contentMode = UIViewContentModeScaleAspectFit;
            indicator.image = [UIImage imageNamed:@"icon_check"];
            [tableView addSubview:indicator];

        }
        else {
            textLabel.textColor = UIColorFromRGBWithAlpha(0x2d3035, 0.5);
            
        }
        
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.font = self.titleLlb.font;
        [tableView addSubview:textLabel];
        
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = kButtonTagOffset + i;
        
        [tableView addSubview:button];
        
        
        
        currY += self.cellHeight;
    }
    
    [self.contentView addSubview:tableView];
}

- (IBAction)buttonTapped:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self.delegate tableCell:self couponAtIndexDidChanceState:(int)(button.tag - kButtonTagOffset)];
}


@end
