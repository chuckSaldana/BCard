//
//  KBCCardVC.h
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 15/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kCardOrientationPortrait,
    kCardOrientationLandscape
} KBCCardOrientation;

@interface KBCCardVC : UIViewController

- (instancetype)initWithOrientation:(KBCCardOrientation)cardOrientation;
@property KBCCardOrientation orientation;

@end
