//
//  BeaconViewController.h
//  VidaHome
//
//  Created by Wenqi Zhou on 2015-01-07.
//  Copyright (c) 2015 Vida. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Transmitter : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSNumber *rssi;
@property (nonatomic, strong) NSNumber *previousRSSI;
@property (nonatomic, strong) NSDate *lastSighted;
@property (nonatomic, strong) NSNumber *batteryLevel;
@property (nonatomic, strong) NSNumber *temperature;

@end
