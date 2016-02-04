//
//  KBCPeripheralManager.m
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 26/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "KBCPeripheralManager.h"

@interface KBCPeripheralManager () <CBPeripheralManagerDelegate>

@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic *transferCharacteristic;
@property (strong, nonatomic) NSData *dataToSend;
@property (nonatomic, readwrite) NSInteger sendDataIndex;

@end

@implementation KBCPeripheralManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)startAdvertizing {
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    [_peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] }];
}

- (void)stoptAdvertizing {
    [_peripheralManager stopAdvertising];
}

#pragma mark - CBPeripheralManagerDelegate conformance

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    switch (peripheral.state) {
        case CBPeripheralManagerStateUnknown:
            [self fireUpdateNotificationForStatus:@"There's a problem with your phone's bluetooth, it might need technical assistance."];
            break;
        case CBPeripheralManagerStateResetting:
            [self fireUpdateNotificationForStatus:@"There's a problem with your phone's bluetooth, it might need technical assistance."];
            break;
        case CBPeripheralManagerStateUnsupported:
            [self fireUpdateNotificationForStatus:@"This app is not enabled to share using bluetooth."];
            break;
        case CBPeripheralManagerStateUnauthorized:
            [self fireUpdateNotificationForStatus:@"It seems you have not authorize BC app to use bluetooth. Please give your permission at settings app."];
            break;
        case CBPeripheralManagerStatePoweredOff:
            [self fireUpdateNotificationForStatus:@"Your bluetooth is turn off. Please turn it on to start sharing."];
            break;
        case CBPeripheralManagerStatePoweredOn:
            [self configureTransferCharacteristics];
            break;
            
        default:
            break;
    }
}

- (void)configureTransferCharacteristics {
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    CBMutableService *transferService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID] primary:YES];
    
    transferService.characteristics = @[_transferCharacteristic];
    
    [_peripheralManager addService:transferService];
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    
    _dataToSend = [@"Carlos Business Card" dataUsingEncoding:NSUTF8StringEncoding];
    
    _sendDataIndex = 0;
    
    [self sendData];
}

- (void)sendData {
    
    static BOOL sendingEOM = NO;
    
    // end of message?
    if (sendingEOM) {
        BOOL didSend = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        if (didSend) {
            // It did, so mark it as sent
            sendingEOM = NO;
        }
        // didn't send, so we'll exit and wait for peripheralManagerIsReadyToUpdateSubscribers to call sendData again
        return;
    }
    
    // We're sending data
    // Is there any left to send?
    if (self.sendDataIndex >= self.dataToSend.length) {
        // No data left.  Do nothing
        return;
    }
    
    // There's data left, so send until the callback fails, or we're done.
    BOOL didSend = YES;
    
    while (didSend) {
        // Work out how big it should be
        NSInteger amountToSend = self.dataToSend.length - self.sendDataIndex;
        
        // Can't be longer than 20 bytes
        if (amountToSend > NOTIFY_MTU) amountToSend = NOTIFY_MTU;
        
        // Copy out the data we want
        NSData *chunk = [NSData dataWithBytes:self.dataToSend.bytes+self.sendDataIndex length:amountToSend];
        
        didSend = [self.peripheralManager updateValue:chunk forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        // If it didn't work, drop out and wait for the callback
        if (!didSend) {
            return;
        }
        
        NSString *stringFromData = [[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding];
        NSLog(@"Sent: %@", stringFromData);
        [self fireUpdateNotificationForStatus:@"Profile sent!"];
        
        // It did send, so update our index
        self.sendDataIndex += amountToSend;
        
        // Was it the last one?
        if (self.sendDataIndex >= self.dataToSend.length) {
            
            // Set this so if the send fails, we'll send it next time
            sendingEOM = YES;
            
            BOOL eomSent = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
            
            if (eomSent) {
                // It sent, we're all done
                sendingEOM = NO;
                NSLog(@"Sent: EOM");
            }
            
            return;
        }
    }
}

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral {
    [self sendData];
}

- (void)fireUpdateNotificationForStatus:(NSString *)status {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                    message:status
                                                   delegate:nil
                                          cancelButtonTitle:@"Close"
                                          otherButtonTitles: nil];
    [alert show];
}


@end
