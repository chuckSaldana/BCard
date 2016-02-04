//
//  KBCCentralManagerProtocol.h
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 26/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBCCentralManagerProtocol <NSObject>

- (void)startScanning;
- (void)stopScanning;

@end
