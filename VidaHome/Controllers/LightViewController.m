//
//  LightViewController.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "LightViewController.h"
#import "NetworkManager.h"
#import "ColorPickerViewController.h"

#define SPACE_INSET 20.0f
#define LABEL_WIDTH 145.0f

@interface LightViewController () {
    CGFloat width, height;
}

@end

@implementation LightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
}

-(NSString *)title {return @"Light";}

- (void)buildUI
{
    [self.view setBackgroundColor:[ApplicationStyle backgroundColor]];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    UILabel *lightLabel = [[UILabel alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], [ApplicationStyle navigationBarHeight]+SPACE_INSET, LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [lightLabel setText:@"Light Switch:"];
    [self.view addSubview:lightLabel];
    
    UISwitch *lightSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(LABEL_WIDTH, 0, 0, 0)];
    [lightSwitch addTarget:self action:@selector(toggleLight:) forControlEvents:UIControlEventTouchUpInside];
    [lightSwitch centerInHeight:lightLabel.viewHeight forYOffset:[ApplicationStyle navigationBarHeight]+SPACE_INSET];
    [self.view addSubview:lightSwitch];
    
    UILabel *colorLabel = [[UILabel alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], lightLabel.bottomOffset+SPACE_INSET, LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [colorLabel setText:@"Light Color:"];
    [self.view addSubview:colorLabel];
    
    UIButton *colorPicker = [[UIButton alloc]initWithFrame:CGRectMake(LABEL_WIDTH, 0, [ApplicationStyle buttonWidth], [ApplicationStyle buttonHeight])];
    [colorPicker setTitle:@"Pick Color" forState:UIControlStateNormal];
    [colorPicker setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [colorPicker.layer setCornerRadius:[ApplicationStyle buttonHeight]/2];
    [colorPicker.layer setMasksToBounds:YES];
    [colorPicker.layer setBorderWidth:1];
    [colorPicker.layer setBorderColor:[UIColor blackColor].CGColor];
    [colorPicker addTarget:self action:@selector(pickColor:) forControlEvents:UIControlEventTouchUpInside];
    [colorPicker centerInHeight:colorLabel.viewHeight forYOffset:lightLabel.bottomOffset+SPACE_INSET];
    [self.view addSubview:colorPicker];
    
}

-(void)toggleLight:(UISwitch *)sender
{
    BOOL isOn;
    if (sender.isOn) {
        isOn = YES;
    } else {
        isOn = NO;
    }
    
    [[NetworkManager sharedInstance] postRequest:@"" parameters:@{@"Light":@(isOn)} success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

-(void)pickColor:(UIButton *)sender
{
    ColorPickerViewController *vc = [ColorPickerViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
