//
//  ACViewController.m
//  VidaHome
//
//  Created by Wenqi Zhou on 2014-11-15.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "ACViewController.h"
#import "PlusMinusButtonView.h"

#define LABEL_WIDTH 145.0f

@interface ACViewController ()<PlusMinusButtonDelegate> {
    CGFloat width, height;
}

@end

@implementation ACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
}

-(NSString *)title {return @"Air Condition";}

- (void)buildUI
{
    [self.view setBackgroundColor:[ApplicationStyle backgroundColor]];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    UILabel *acLabel = [[UILabel alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], [ApplicationStyle navigationBarHeight]+[ApplicationStyle spaceInset], LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [acLabel setText:@"AC Switch:"];
    [self.view addSubview:acLabel];
    
    UISegmentedControl *acSwitch = [[UISegmentedControl alloc]initWithItems:@[@"Heat", @"Cool"]];
    acSwitch.frame = CGRectMake(LABEL_WIDTH, 0, [ApplicationStyle buttonWidth], [ApplicationStyle buttonHeight]);
    [acSwitch centerInHeight:acLabel.viewHeight forYOffset:[ApplicationStyle navigationBarHeight]+[ApplicationStyle spaceInset]];
    acSwitch.selectedSegmentIndex = 0;
    [acSwitch addTarget:self action:@selector(changeSelection:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:acSwitch];
    
    UILabel *thermostatLabel = [[UILabel alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], acSwitch.bottomOffset+[ApplicationStyle spaceInset], LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [thermostatLabel setText:@"Thermostat:"];
    [self.view addSubview:thermostatLabel];
    
    UISwitch *thermostatSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(LABEL_WIDTH, 0, 0, 0)];
    [thermostatSwitch addTarget:self action:@selector(toggleThermostat:) forControlEvents:UIControlEventValueChanged];
    [thermostatSwitch centerInHeight:thermostatLabel.viewHeight forYOffset:acSwitch.bottomOffset+[ApplicationStyle spaceInset]];
    [self.view addSubview:thermostatSwitch];
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], thermostatLabel.bottomOffset+[ApplicationStyle spaceInset], LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [tempLabel setText:@"Temperature:"];
    [self.view addSubview:tempLabel];
    
    PlusMinusButtonView *plusButtonView = [PlusMinusButtonView initPlusMinusButtonViewWithCurrentValue:0 minValue:0 maxValue:100];
    [plusButtonView setEnabled:YES];
    plusButtonView.delegate = self;
    [plusButtonView centerInHeight:tempLabel.viewHeight forYOffset:thermostatLabel.bottomOffset+[ApplicationStyle spaceInset]];
    [plusButtonView setXPosition:LABEL_WIDTH];
    [self.view addSubview:plusButtonView];
}

- (void)changeSelection:(UISegmentedControl *)sender
{
    BOOL heat;
    if (sender.selectedSegmentIndex == 0) {
        heat = YES;
    } else {
        heat = NO;
    }
    
    [[NetworkManager sharedInstance] postRequest:@"" parameters:@{@"Heat":@(heat)} success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

-(void)toggleThermostat:(UISwitch *)sender
{
    BOOL isOn;
    if (sender.isOn) {
        isOn = YES;
    } else {
        isOn = NO;
    }
    
    [[NetworkManager sharedInstance] postRequest:@"" parameters:@{@"Thermostat":@(isOn)} success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

- (void)plusMinusButtonUpdated:(NSInteger)value {
    [[NetworkManager sharedInstance] postRequest:@"" parameters:@{@"Temperature":@(value)} success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}
@end
