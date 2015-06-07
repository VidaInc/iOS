//
//  TodayViewController.m
//  LightWidget
//
//  Created by Wenqi Zhou on 2015-06-02.
//  Copyright (c) 2015 Vida. All rights reserved.
//

#import "TodayViewController.h"
#import "ABLightSDK.h"
#import "AprilBeaconSDK.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding, ABLightDelegate, ABLightManagerDelegate, ABBeaconManagerDelegate>

@property (nonatomic) ABLightManager *lightManager;
@property (nonatomic, strong) ABBeaconManager *beaconManager;
@property (nonatomic) ABLight *light;
@property (weak, nonatomic) IBOutlet UILabel *lightLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lightManager = [ABLightManager new];
    self.lightManager.delegate = self;
    self.beaconManager = [[ABBeaconManager alloc] init];
    self.beaconManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.lightManager startDiscoverLight];
    [self.beaconManager startAprilBeaconsDiscovery];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (IBAction)switchControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.light setLightValue:255 withCompletion:^(NSError *error) {
            NSLog(@"Success");
        }];
    } else {
        [self.light setLightValue:0 withCompletion:^(NSError *error) {
            NSLog(@"Success");
        }];
    }
}

-(void)lightManager:(ABLightManager *)manager didDiscoverLights:(NSArray *)lights
{
    if ([lights count]>0) {
        self.light = lights[0];
        self.light.delegate = self;
        [self.light connect];
    }
}

-(void)lightDidConnected:(ABLight *)light withError:(NSError *)error
{
    [self.lightLabel setText:@"Connected"];
}

- (void)beaconManager:(ABBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons{
    NSLog(@"send request");
}

@end
