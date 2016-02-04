//
//  KBCPeripheralManager.h
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 26/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBCPeripheralManagerProtocol.h"

@protocol KBCPeripheralManagerDelegate;

@interface KBCPeripheralManager : NSObject <KBCPeripheralManagerProtocol>

@property (weak, nonatomic) id <KBCPeripheralManagerDelegate> delegate;

@end

@protocol KBCPeripheralManagerDelegate <NSObject>

- (void)peripheralManagerharingSuccessful:(KBCPeripheralManager *)peripheralManager;    

@end
