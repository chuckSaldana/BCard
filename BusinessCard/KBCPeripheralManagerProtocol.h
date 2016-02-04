//
//  KBCPeripheralManagerProtocol.h
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 26/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBCPeripheralManagerProtocol <NSObject>

- (void)startAdvertizing;
- (void)stoptAdvertizing;

@end
