//
//  BeaconViewController.m
//  VidaHome
//
//  Created by Wenqi Zhou on 2015-01-07.
//  Copyright (c) 2015 Vida. All rights reserved.
//

#import "BeaconViewController.h"
#import "Transmitter.h"
#import "BeaconTableViewCell.h"
#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXTransmitter.h>
#define LABEL_WIDTH 145.0f

@interface BeaconViewController () <UITableViewDataSource, UITableViewDelegate, FYXServiceDelegate, FYXVisitDelegate>{
    CGFloat width, height;
}

@property NSMutableArray *transmitters;
@property FYXVisitManager *visitManager;
@property (nonatomic) UITableView *tableView;

@end

@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [FYX startService:self];
    [self buildUI];
}

- (void)buildUI
{
    [self.view setBackgroundColor:[ApplicationStyle backgroundColor]];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    /*UILabel *beaconLabel = [[UILabel alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], [ApplicationStyle navigationBarHeight]+[ApplicationStyle spaceInset], LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [beaconLabel setText:@"Beacon Detect:"];
    [self.view addSubview:beaconLabel];
    
    UILabel *batteryLabel = [[UILabel alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], [ApplicationStyle navigationBarHeight]+[ApplicationStyle spaceInset], LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [beaconLabel setText:@"Beacon Battery:"];
    [self.view addSubview:batteryLabel];
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], tempLabel.bottomOffset+[ApplicationStyle spaceInset], LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [tempLabel setText:@"Temperature:"];
    [self.view addSubview:tempLabel];*/
}

#pragma mark - FYX Delegate methods
- (void)serviceStarted
{
    NSLog(@"#########Proximity service started!");
    
    self.transmitters = [NSMutableArray new];
    
    [self.navigationController.navigationBar.topItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon_binoculars.png"]]];
    
    self.visitManager = [[FYXVisitManager alloc] init];
    self.visitManager.delegate = self;
    [self.visitManager start];
}

- (void)startServiceFailed:(NSError *)error
{
    NSLog(@"#########Proximity service failed to start! error is: %@", error);
    
    NSString *message = @"Service failed to start, please check to make sure your Application Id and Secret are correct.";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Proximity Service"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
//{"uuid":"00000000-0000-0000-0000-000000000002","major":0,"minor":0}
#pragma mark - FYX visit delegate
- (void)didArrive:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter is sighted for the first time
    NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
}

- (void)didDepart:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
    Transmitter *transmitter = [[self.transmitters filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", visit.transmitter.identifier]] firstObject];
    [self.transmitters removeObject:transmitter];
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    // this will be invoked when an authorized transmitter is sighted during an on-going visit
    NSLog(@"I received a sighting!!! %@", visit.transmitter.name);
    
    Transmitter *transmitter = [[self.transmitters filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", visit.transmitter.identifier]] firstObject];
    if (transmitter == nil)
    {
        transmitter = [Transmitter new];
        transmitter.identifier = visit.transmitter.identifier;//Q2XR-FJHFR
        transmitter.name = visit.transmitter.name ? visit.transmitter.name : visit.transmitter.identifier;//4
        transmitter.lastSighted = [NSDate dateWithTimeIntervalSince1970:0];
        transmitter.rssi = [NSNumber numberWithInt:-100];//-100
        transmitter.previousRSSI = transmitter.rssi;
        transmitter.batteryLevel = 0;
        transmitter.temperature = 0;
        
        [self.transmitters addObject:transmitter];
        
        //[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.transmitters.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

    transmitter.previousRSSI = transmitter.rssi;
    transmitter.rssi = RSSI;
    transmitter.batteryLevel = visit.transmitter.battery;
    transmitter.temperature = visit.transmitter.temperature;
    transmitter.inRange = NO;
    transmitter.needHeat = NO;
    int rssi = [transmitter.rssi intValue];
    int battery = [transmitter.batteryLevel intValue];
    int temp = [transmitter.temperature intValue];
    
    transmitter.lastSighted = updateTime;
    if ([transmitter.rssi intValue] > -70) {
        if ([transmitter.previousRSSI intValue] < -70) {
            transmitter.inRange = YES;
            if (temp > [ApplicationStyle getPreferTemp]) {
                transmitter.needHeat = NO;
            } else {
                transmitter.needHeat = YES;
            }
            [[NetworkManager sharedInstance] postRequest:[NSString stringWithFormat:@"iBeacon/%@", transmitter.identifier] parameters:@{@"userId":[ApplicationStyle getUserId],@"needHeat":@(transmitter.needHeat), @"inRange":@YES, @"rssi":@(rssi), @"batteryLevel":@(battery), @"currentTemperature":@(temp), @"preferTemperature":@([ApplicationStyle getPreferTemp])} success:^(id responseObject) {
                NSLog(@"Success");
            } failure:^(NSError *error) {
                NSLog(@"fail");
            }];

        } else if (temp > [ApplicationStyle getPreferTemp] && transmitter.needHeat == YES){
            transmitter.needHeat = NO;
            [[NetworkManager sharedInstance] postRequest:[NSString stringWithFormat:@"iBeacon/%@", transmitter.identifier] parameters:@{@"userId":[ApplicationStyle getUserId],@"needHeat":@(transmitter.needHeat), @"inRange":@YES, @"rssi":@(rssi), @"batteryLevel":@(battery), @"currentTemperature":@(temp), @"preferTemperature":@([ApplicationStyle getPreferTemp])} success:^(id responseObject) {
                NSLog(@"Success");
            } failure:^(NSError *error) {
                NSLog(@"fail");
            }];
        } else if (temp < [ApplicationStyle getPreferTemp] && transmitter.needHeat == NO){
            transmitter.needHeat = YES;
            [[NetworkManager sharedInstance] postRequest:[NSString stringWithFormat:@"iBeacon/%@", transmitter.identifier] parameters:@{@"userId":[ApplicationStyle getUserId],@"needHeat":@(transmitter.needHeat), @"inRange":@YES, @"rssi":@(rssi), @"batteryLevel":@(battery), @"currentTemperature":@(temp), @"preferTemperature":@([ApplicationStyle getPreferTemp])} success:^(id responseObject) {
                NSLog(@"Success");
            } failure:^(NSError *error) {
                NSLog(@"fail");
            }];
        }
    } else {
        if ([transmitter.previousRSSI intValue] > -70) {
            transmitter.inRange = NO;
            [[NetworkManager sharedInstance] postRequest:[NSString stringWithFormat:@"iBeacon/%@", transmitter.identifier] parameters:@{@"userId":[ApplicationStyle getUserId],@"inRange":@NO} success:^(id responseObject) {
                NSLog(@"Success");
            } failure:^(NSError *error) {
                NSLog(@"fail");
            }];
        }
    }
    /*if ([self shouldUpdateTransmitterCell:visit transmitter:transmitter RSSI:RSSI])
    {
        transmitter.previousRSSI = transmitter.rssi;
        transmitter.rssi = RSSI;
        transmitter.batteryLevel = visit.transmitter.battery;
        transmitter.temperature = visit.transmitter.temperature;
        int rssi = [transmitter.rssi intValue];
        int battery = [transmitter.batteryLevel intValue];
        int temp = [transmitter.temperature intValue];

        [[NetworkManager sharedInstance] postRequest:[NSString stringWithFormat:@"iBeacon/%@", transmitter.identifier] parameters:@{@"ON":@YES, @"rssi":@(rssi), @"batteryLevel":@(battery), @"currentTemperature":@(temp), @"preferTemperature":@([ApplicationStyle getPreferTemp])} success:^(id responseObject) {
            NSLog(@"Success");
        } failure:^(NSError *error) {
            NSLog(@"fail");
        }];
    }*/
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.transmitters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyReusableCell";
    BeaconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell != nil)
    {
        Transmitter *transmitter = [self.transmitters objectAtIndex:indexPath.row];
        
        [cell.rssi setText:[NSString stringWithFormat:@"rssi: %@", transmitter.rssi]];
        [cell.temperature setText:[NSString stringWithFormat:@"temp: %@", transmitter.temperature]];
    }
    return cell;
}


- (BOOL)shouldUpdateTransmitterCell:(FYXVisit *)visit transmitter:(Transmitter *)transmitter RSSI:(NSNumber *)rssi
{
    if ([rssi intValue] > -70) {
        return YES;
    } else {
        if ([transmitter.previousRSSI intValue] > -70) {
            
            [[NetworkManager sharedInstance] postRequest:[NSString stringWithFormat:@"iBeacon/%@", transmitter.identifier] parameters:@{@"ON":@NO} success:^(id responseObject) {
                NSLog(@"Success");
            } failure:^(NSError *error) {
                NSLog(@"fail");
            }];
        }
        return NO;
    }
    return NO;
}
@end
