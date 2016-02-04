//
//  KBCMenuVC.m
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 18/05/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "KBCMenuVC.h"
#import "KBCCardShareVC.h"
#import "KBCMyCardsVC.h"
#import "KBCConcactListVC.h"
#import "KBCSettingsVC.h"

@interface KBCMenuVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *cellTitles;
@property (strong, nonatomic) KBCCardShareVC *cardShare;
@property (strong, nonatomic) KBCMyCardsVC *myCards;
@property (strong, nonatomic) KBCConcactListVC *contactList;
@property (strong, nonatomic) KBCSettingsVC *settingsVC;

@end

@implementation KBCMenuVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.cellTitles = @[@"Share", @"Contacts", @"Cards", @"Settings"];
        [self initializeViewControllers];
    }
    return self;
}

- (void)initializeViewControllers {
    
    KBCCentralManager *centralMgr = [[KBCCentralManager alloc] init];
    KBCPeripheralManager *peripheralMgr = [[KBCPeripheralManager alloc] init];
    self.cardShare = [[KBCCardShareVC alloc] initWithCentralManager:centralMgr peripheralManager:peripheralMgr];
    self.myCards = [[KBCMyCardsVC alloc] init];
    self.contactList = [[KBCConcactListVC alloc] init];
    self.settingsVC = [[KBCSettingsVC alloc] init];
}

- (void)myCardsTapped:(id)sender {
    
    [MainSidePanel setCenterPanel:self.myCards];
    [MainSidePanel showCenterPanelAnimated:YES];
}

- (void)inboxTappped:(id)sender {
    [MainSidePanel setCenterPanel:self.myCards];
    [MainSidePanel showCenterPanelAnimated:YES];
}

- (void)bCardTapped:(id)sender {
    [MainSidePanel setCenterPanel:self.cardShare];
    [MainSidePanel showCenterPanelAnimated:YES];
}

- (void)settingsTapped:(id)sender {
    [MainSidePanel setCenterPanel:self.settingsVC];
    [MainSidePanel showCenterPanelAnimated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.cellTitles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self bCardTapped:nil];
            break;
        case 1:
            [self inboxTappped:nil];
            break;
        case 2:
            [self myCardsTapped:nil];
            break;
        case 3:
            [self settingsTapped:nil];
            break;
        default:
            [self bCardTapped:nil];
            break;
    }
}

@end
