//
//  DTableCell.h
//  Diamond
//
//  Created by Carlos Saldaña Garcia on 01/05/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSubcategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLlb;
@property (weak, nonatomic) IBOutlet UIButton *button;

- (void)addSpinner;

@end

