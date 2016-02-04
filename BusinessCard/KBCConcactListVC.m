//
//  KBCConcactListVC.m
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 18/05/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "KBCConcactListVC.h"

@interface KBCConcactListVC ()

@end

@implementation KBCConcactListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)showMenu:(id)sender {
    [MainSidePanel showLeftPanelAnimated:YES];
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
