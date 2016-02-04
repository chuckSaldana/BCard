//
//  KBCSettingsVC.m
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 18/05/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "KBCSettingsVC.h"
#import "DTextFLabelCell.h"
#import "DSwitchCell.h"

static NSString *textCellID = @"TextCellID";
static NSString *switchCellID = @"SwitchCellID";

@interface KBCSettingsVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, DSwitchCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary   *valuesDict;
@property (strong, nonatomic) NSMutableArray   *editArray;

@property (strong, nonatomic) UITextField *currentTextField;

@end

@implementation KBCSettingsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    
    
    if (![self retrieveUserInfo]) {
        
        self.valuesDict = [@{@"zipcode" : @"",
                             @"radius" : @"",
                             @"allow_location" : @0,
                             @"push_n" : @0,
                             @"sounds" : @0,
                             @"vibrate" : @0,
                             @"in_store" : @0,
                             @"expiring" : @0,
                             @"favorite" : @0
                             } mutableCopy];
    }
    
    
    self.editArray = [@[@{@"section_title" : @"My Location", @"section_rows" : @[@{@"placeholder" : @"Default Zip",
                                                                                   @"key" : @"zipcode",
                                                                                   @"kind" : @"textF_Lbl"},
                                                                                 
                                                                                 @{@"placeholder" : @"Map Radius",
                                                                                   @"key" : @"radius",
                                                                                   @"kind" : @"textF_Lbl"},
                                                                                 
                                                                                 @{@"placeholder" : @"Allow Location",
                                                                                   @"key" : @"allow_location",
                                                                                   @"kind" : @"switch"}
                                                                                 ]
                          },
                        @{@"section_title" : @"Notifications", @"section_rows" : @[@{@"placeholder" : @"Push Notifications",
                                                                                     @"key" : @"push_n",
                                                                                     @"kind" : @"switch"},
                                                                                   @{@"placeholder" : @"Sounds",
                                                                                     @"key" : @"sounds",
                                                                                     @"kind" : @"switch"},
                                                                                   @{@"placeholder" : @"Vibrate",
                                                                                     @"key" : @"vibrate",
                                                                                     @"kind" : @"switch"},
                                                                                   @{@"placeholder" : @"In-Store Reminders",
                                                                                     @"key" : @"in_store",
                                                                                     @"kind" : @"switch"},
                                                                                   @{@"placeholder" : @"Expiring Coupon Reminder",
                                                                                     @"key" : @"expiring",
                                                                                     @"kind" : @"switch"},
                                                                                   @{@"placeholder" : @"Favorite Coupons",
                                                                                     @"key" : @"favorite",
                                                                                     @"kind" : @"switch"}
                                                                                   ]
                          }
                        ] mutableCopy];
    
}
- (IBAction)backToMyAccount:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)currentArray {
    
    return self.editArray;
}

#pragma mark - UITableView protocols conformance

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self currentArray].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self currentArray][section][@"section_rows"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *sectionDict = [self currentArray][indexPath.section];
    NSArray *rowsArr = sectionDict[@"section_rows"];
    NSDictionary *rowDict = rowsArr[indexPath.row];
    NSString *kind = rowDict[@"kind"];
    
    if ([kind isEqualToString:@"textF_Lbl"]) {
        DTextFLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DTextFLabelCell" owner:nil options:nil] lastObject];
            cell.cellTextField.delegate = self;
            cell.cellTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        cell.cellTextField.text = self.valuesDict[rowDict[@"key"]];
        cell.textLbl.text = rowDict[@"placeholder"];
        
        return cell;
    }
    else if ([kind isEqualToString:@"switch"]) {
        DSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DSwitchCell" owner:nil options:nil] lastObject];
            cell.delegate = self;
        }
        
        cell.textLbl.text = rowDict[@"placeholder"];
        [cell.theSwitch setOn:[self.valuesDict[rowDict[@"key"]] boolValue]];
        
        return cell;
    }
    else {
        DTextFLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DTextFLabelCell" owner:nil options:nil] lastObject];
            cell.cellTextField.delegate = self;
        }
        return cell;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.currentTextField resignFirstResponder];
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *sectionDict = [self currentArray][indexPath.section];
    NSArray *rowsArr = sectionDict[@"section_rows"];
    NSDictionary *rowDict = rowsArr[indexPath.row];
    NSString *kind = rowDict[@"kind"];
    
    if ([kind isEqualToString:@"textF_Lbl"]) {
        return 70;
    }
    else if ([kind isEqualToString:@"switch"]) {
        return 50;
    }
    else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.backgroundColor = UIColorFromRGB(0xbbbbbb);
    
    UILabel *sectionLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 17, 280, 16)];
    sectionLbl.textColor = UIColorFromRGB(0x888888);
    sectionLbl.font = [UIFont boldSystemFontOfSize:16];
    sectionLbl.text = [self currentArray][section][@"section_title"];
    
    [view addSubview:sectionLbl];
    
    return view;
}

#pragma mark - DSwitchCellDelegate conformance

- (void)switchCell:(DSwitchCell *)switchCell switchValueChanged:(UISwitch *)theSwitch {
    
    NSIndexPath *cellIndex = [self.tableView indexPathForCell:switchCell];
    NSString *key = [self currentArray][cellIndex.section][@"section_rows"][cellIndex.row][@"key"];
    
    [self.valuesDict setObject:[NSNumber numberWithBool:theSwitch.isOn] forKey:key];
    [self storeUserInfo];
}

- (BOOL)storeUserInfo {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString* docFile = [docDir stringByAppendingPathComponent: @"userInfo.plist"];
    NSError* error;
    
    if([NSKeyedArchiver archiveRootObject:self.valuesDict toFile:docFile]) {
        
        NSDictionary *fileAttributes = [NSDictionary
                                        dictionaryWithObject:NSFileProtectionComplete
                                        forKey:NSFileProtectionKey];
        if([[NSFileManager defaultManager] setAttributes:fileAttributes
                                            ofItemAtPath:docFile  error: &error]) {
            NSLog(@"Values saved!");
            return YES;
        }
        else {
            NSLog(@"%@", error);
            return NO;
        }
    }
    
    return NO;
}

- (BOOL)retrieveUserInfo {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString* docFile = [docDir stringByAppendingPathComponent: @"userInfo.plist"];
    
    self.valuesDict = [NSKeyedUnarchiver unarchiveObjectWithFile:docFile];
    if (self.valuesDict) {
        return YES;
    }
    
    return NO;
}


#pragma mark - UITextFieldDelegate conformance

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    for (int section = 0; section < [[self currentArray] count]; section++) {
        NSMutableDictionary *aSection = [[self currentArray][section] mutableCopy];
        NSMutableArray *rows = [aSection[@"section_rows"] mutableCopy];
        for (int row = 0; row < [rows count]; row++) {
            NSMutableDictionary *aRow = [rows[row] mutableCopy];
            
            if ([aRow[@"placeholder"] isEqualToString:textField.placeholder]) {
                [self.valuesDict setObject:textField.text forKey:aRow[@"key"]];
            }
        }
    }
    
    [self storeUserInfo];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)showMenu:(id)sender {
    [MainSidePanel showLeftPanelAnimated:YES];
}

@end
