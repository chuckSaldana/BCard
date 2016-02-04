//
//  KBCCardShareVC.h
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 15/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "KBCCentralManager.h"
#import "KBCPeripheralManager.h"
#import "KBCCentralManagerProtocol.h"
#import "KBCPeripheralManagerProtocol.h"

@interface KBCCardShareVC : UIViewController

- (id)initWithCentralManager:(id <KBCCentralManagerProtocol>)centralMgr peripheralManager:(id <KBCPeripheralManagerProtocol>)peripheralMgr;

@end
