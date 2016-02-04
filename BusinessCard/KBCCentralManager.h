//
//  KBCCentralManager.h
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 26/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBCCentralManagerProtocol.h"

@protocol KBCCentralManagerDelegate;

@interface KBCCentralManager : NSObject <KBCCentralManagerProtocol>

@property (weak, nonatomic) id <KBCCentralManagerDelegate> delegate;

@end


@protocol KBCCentralManagerDelegate <NSObject>

- (void)centralManagersharingSuccessful:(KBCCentralManager *)centralManager;

@end