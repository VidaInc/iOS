//
//  LightViewController.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "LightViewController.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildUI
{
    [self.view setBackgroundColor:[ApplicationStyle backgroundColor]];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    UISwitch *lightSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [lightSwitch centerInWidth:width];
    [lightSwitch centerInHeight:height];
    [self.view addSubview:lightSwitch];
}

@end
