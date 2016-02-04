//
//  KBCCardVC.m
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 15/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "KBCCardVC.h"

@interface KBCCardVC ()

@end

@implementation KBCCardVC

- (instancetype)initWithOrientation:(KBCCardOrientation)cardOrientation {
    self = [super init];
    if (self) {
        self.orientation = cardOrientation;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
