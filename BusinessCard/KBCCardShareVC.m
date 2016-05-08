//
//  KBCCardShareVC.m
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 15/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "KBCCardShareVC.h"
#import "KBCCardVC.h"
#import "KBCProfile.h"

@interface KBCCardShareVC () 

@property (strong, nonatomic) KBCCentralManager *centralManager;
@property (strong, nonatomic) KBCPeripheralManager *peripheralManager;

//@property BOOL centralShared;
//@property BOOL peripheralShared;

@property (strong, nonatomic) NSMutableArray *receivedProfiles;

@end

@implementation KBCCardShareVC

- (id)initWithCentralManager:(KBCCentralManager *)centralMgr peripheralManager:(KBCPeripheralManager *)peripheralMgr
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.centralManager = centralMgr;
        self.peripheralManager = peripheralMgr;
//        self.centralShared = NO;
//        self.peripheralShared = NO;
        self.receivedProfiles = [NSMutableArray array];
    }
    return self;
}

- (IBAction)advertizeButtonTapped:(id)sender {
    [self.peripheralManager startAdvertizing];
}

- (IBAction)centralButtonTapped:(id)sender {
    [self.centralManager startScanning];
}

- (IBAction)showMenu:(id)sender {
     [MainSidePanel showLeftPanelAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self showSampleCard];
    [self saveSampleUser];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //[self advertizeButtonTapped:nil];
    //[self centralButtonTapped:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.centralManager stopScanning];
    [self.peripheralManager stoptAdvertizing];
}

- (void)showSampleCard {
    KBCCardVC *cardVC = [[KBCCardVC alloc] init];
    CGFloat cardWidth = CGRectGetWidth(self.view.frame) - 20;
    CGFloat cardHeight = CGRectGetHeight(self.view.frame) - 140;
    cardVC.view.frame = CGRectMake(0, 0, cardWidth, cardHeight);
    cardVC.view.center = self.view.center;
    
    [self.view addSubview:cardVC.view];
}

- (void)saveSampleUser {
    PFObject *aUser = [PFObject objectWithClassName:@"KBCUser"];
    aUser[@"firstName"] = @"John";
    aUser[@"lastName"] = @"Doe";
    [aUser saveInBackground];
}


#pragma mark - Utility methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KBCCentralManagerDelegate & KBCPeripheralManagerDelegate conformance

- (void)centralManager:(KBCCentralManager *)centralManager didReceivedProfile:(KBCProfile *)aProfile {
    
    [self.receivedProfiles addObject:aProfile];
    //[self animateForCardReceived];
}

- (void)peripheralManagerSharingSuccessful:(KBCPeripheralManager *)peripheralManager {


}

@end
