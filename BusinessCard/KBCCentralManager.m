//
//  KBCCentralManager.m
//  BusinessCard
//
//  Created by Carlos Saldaña Garcia on 26/04/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "KBCCentralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface KBCCentralManager () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property BOOL finishTransfer;

@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;
@property (strong, nonatomic) NSMutableData *data;

@end

@implementation KBCCentralManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)startScanning {
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    _data = [[NSMutableData alloc] init];
    self.finishTransfer = NO;
}

- (void)stopScanning {
    [_centralManager stopScan];
    [self cleanup];
}

#pragma mark - CBCentralManagerDelegate conformance

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            [self fireUpdateNotificationForStatus:@"There's a problem with your phone's bluetooth, it might need technical assistance."];
            break;
        case CBCentralManagerStateResetting:
            [self fireUpdateNotificationForStatus:@"There's a problem with your phone's bluetooth, it might need technical assistance."];
            return;
            break;
        case CBCentralManagerStateUnsupported:
            [self fireUpdateNotificationForStatus:@"This app is not enabled to share using bluetooth."];
            break;
        case CBCentralManagerStateUnauthorized:
            [self fireUpdateNotificationForStatus:@"It seems you have not authorize BC app to use bluetooth. Please give your permission at settings app."];
            break;
        case CBCentralManagerStatePoweredOff:
            [self fireUpdateNotificationForStatus:@"Your bluetooth is turn off. Please turn it on to start sharing."];
            break;
        case CBCentralManagerStatePoweredOn:
            [self startScanningForService];
            break;
        default:
            return;
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    if (self.finishTransfer) {
        return;
    }
    
    NSLog(@"Discovered %@ at %@", peripheral.name, RSSI);
    
    return;
    
    if (_discoveredPeripheral != peripheral) {
        // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
        _discoveredPeripheral = peripheral;
        
        // And connect
        NSLog(@"Connecting to peripheral %@", peripheral);
        [_centralManager connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"Failed to connect");
    [self cleanup];
}


- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Connected");
    
    [_centralManager stopScan];
    NSLog(@"Scanning stopped");
    
    [_data setLength:0];
    
    peripheral.delegate = self;
    
    [peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
}


- (void)startScanningForService {
    // Scan for devices
    CBUUID *uuid = [CBUUID UUIDWithString:TRANSFER_SERVICE_UUID];
    [_centralManager scanForPeripheralsWithServices:@[uuid] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    NSLog(@"Scanning started");
    [self fireUpdateNotificationForStatus:@"Scanning started"];
}

- (void)fireUpdateNotificationForStatus:(NSString *)status {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                    message:status
                                                   delegate:nil
                                          cancelButtonTitle:@"Close"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)cleanup {
    
    // See if we are subscribed to a characteristic on the peripheral
    if (_discoveredPeripheral.services != nil) {
        for (CBService *service in _discoveredPeripheral.services) {
            if (service.characteristics != nil) {
                for (CBCharacteristic *characteristic in service.characteristics) {
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]) {
                        if (characteristic.isNotifying) {
                            [_discoveredPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                            return;
                        }
                    }
                }
            }
        }
    }
    
    [_centralManager cancelPeripheralConnection:_discoveredPeripheral];
}

#pragma mark - CBPeripheralDelegate conformance

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        [self cleanup];
        return;
    }
    
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:service];
    }
    // Discover other characteristics
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        [self cleanup];
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error");
        return;
    }
    
    NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    // Have we got everything we need?
    if ([stringFromData isEqualToString:@"EOM"]) {
        self.finishTransfer = YES;
        
        NSLog(@"%@", [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding]);
        [self fireUpdateNotificationForStatus:@"Profile received!"];
        
        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
        
        [_centralManager cancelPeripheralConnection:peripheral];
    }
    
    [_data appendData:characteristic.value];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    
    if (characteristic.isNotifying) {
        NSLog(@"Notification began on %@", characteristic);
    } else {
        // Notification has stopped
        [_centralManager cancelPeripheralConnection:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    _discoveredPeripheral = nil;
    
    [_centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
}

@end
