//
//  DoorViewController.m
//  VidaHome
//
//  Created by Wenqi Zhou on 2014-11-15.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "DoorViewController.h"

#define LABEL_WIDTH 145.0f

@interface DoorViewController (){
    CGFloat width, height;
    UITextField *IP, *user;
}

@end

@implementation DoorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [[NetworkManager sharedInstance] getRequest:@"door/1" parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

-(NSString *)title {return @"Door";}

- (void)buildUI
{
    [self.view setBackgroundColor:[ApplicationStyle backgroundColor]];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    UILabel *doorLabel = [[UILabel alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], [ApplicationStyle navigationBarHeight]+[ApplicationStyle spaceInset], LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [doorLabel setText:@"Lock:"];
    [self.view addSubview:doorLabel];
    
    UISwitch *lockSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(LABEL_WIDTH, 0, 0, 0)];
    [lockSwitch addTarget:self action:@selector(toggleDoor:) forControlEvents:UIControlEventValueChanged];
    [lockSwitch centerInHeight:doorLabel.viewHeight forYOffset:[ApplicationStyle navigationBarHeight]+[ApplicationStyle spaceInset]];
    [self.view addSubview:lockSwitch];
    IP = [[UITextField alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], doorLabel.bottomOffset+[ApplicationStyle spaceInset], width, [ApplicationStyle buttonHeight])];
    [IP.layer setBorderWidth:1];
    [self.view addSubview:IP];
    user = [[UITextField alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], IP.bottomOffset+[ApplicationStyle spaceInset], width, [ApplicationStyle buttonHeight])];
    [user.layer setBorderWidth:1];
    [self.view addSubview:user];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([ApplicationStyle horizontalInset], user.bottomOffset+[ApplicationStyle spaceInset], LABEL_WIDTH, [ApplicationStyle buttonHeight])];
    [button setBackgroundColor:[UIColor blackColor]];
    [button setTitle:@"submit" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addIP:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)addIP:(UIButton *)button
{
    [ApplicationStyle setIP:IP.text];
    [ApplicationStyle setUser:user.text];
    [[NetworkManager sharedInstance]createManagerWithBaseURL:[ApplicationStyle baseURLString]];
}

-(void)toggleDoor:(UISwitch *)sender
{
    BOOL isOn;
    if (sender.isOn) {
        isOn = YES;
    } else {
        isOn = NO;
    }
    
    [[NetworkManager sharedInstance] postRequest:@"door/1" parameters:@{@"Door":@(isOn)} success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

@end
