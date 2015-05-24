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

- (void)viewWillDisappear:(BOOL)animated
{
    [self.light disconnect];
}

-(NSString *)title {return @"Light";}

- (IBAction)toggle:(UISwitch *)sender {
    BOOL isOn;
    if (sender.isOn) {
        isOn = YES;
        [self.light setLightValue:255 withCompletion:^(NSError *error) {
            NSLog(@"Success");
        }];
    } else {
        [self.light setLightValue:0 withCompletion:^(NSError *error) {
            NSLog(@"Success");
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
    [self.light setLightValue:ceil(sender.value) withCompletion:^(NSError *error) {
        NSLog(@"Success");
    }];
}

@end
