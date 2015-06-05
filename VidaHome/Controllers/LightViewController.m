//
//  LightStatusViewController.m
//  VidaHome
//
//  Created by Wenqi Zhou on 2015-05-24.
//  Copyright (c) 2015 Vida. All rights reserved.
//

#import "LightViewController.h"
#import "ColorPickerViewController.h"

@interface LightViewController () {
    CGFloat width, height;
}

@end

@implementation LightViewController

-(BOOL)automaticallyAdjustsScrollViewInsets {return YES;}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    /*[[NetworkManager sharedInstance] getRequest:@"light/1" parameters:nil success:^(id responseObject) {
     NSLog(@"%@",responseObject);
     } failure:^(NSError *error) {
     NSLog(@"fail");
     }];*/
}


-(NSString *)title {return @"Light";}

- (IBAction)toggle:(UISwitch *)sender {
    BOOL isOn;
    if (sender.isOn) {
        isOn = YES;
        [[NetworkManager sharedInstance] postRequest:@"light" parameters:@{@"userId":[ApplicationStyle getUserId], @"UUID":self.beacon.proximityUUID.UUIDString, @"major":@([self.beacon.major intValue]), @"minor":@([self.beacon.minor intValue]), @"rssi":@(self.beacon.rssi), @"brightness":@(255)} success:^(id responseObject) {
            NSLog(@"Success");
        } failure:^(NSError *error) {
            NSLog(@"fail");
        }];
    } else {
        [[NetworkManager sharedInstance] postRequest:@"light" parameters:@{@"userId":[ApplicationStyle getUserId], @"UUID":self.beacon.proximityUUID.UUIDString, @"major":@([self.beacon.major intValue]), @"minor":@([self.beacon.minor intValue]), @"rssi":@(self.beacon.rssi), @"brightness":@(0)} success:^(id responseObject) {
            NSLog(@"Success");
        } failure:^(NSError *error) {
            NSLog(@"fail");
        }];
    }
}

- (IBAction)pickColour:(UIButton *)sender
{
    ColorPickerViewController *vc = [ColorPickerViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)changeBrightness:(UISlider *)sender
{
    NSLog(@"%.2f",sender.value);
    [[NetworkManager sharedInstance] postRequest:@"light" parameters:@{@"userId":[ApplicationStyle getUserId], @"UUID":self.beacon.proximityUUID.UUIDString, @"major":@([self.beacon.major intValue]), @"minor":@([self.beacon.minor intValue]), @"rssi":@(self.beacon.rssi), @"brightness":@(sender.value)} success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

@end
