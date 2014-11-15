//
//  SideBarViewController.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "SideBarViewController.h"
#import "LightViewController.h"
#import "ACViewController.h"
#import "DoorViewController.h"

typedef NS_ENUM(NSInteger, SidebarOption)
{
    SidebarOptionLight = 0,
    SidebarOptionAirCondition,
    SidebarOptionDoor,
    SidebarOptionCount
};

@interface SideBarViewController () {
    CGFloat width, height;
}

@end

@implementation SideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
}

- (void)buildUI
{
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    [self.view setBackgroundColor:[ApplicationStyle backgroundDarkColor]];
    [self.navigationController setNavigationBarHidden:YES];
    
    UIButton *light = [[UIButton alloc]initWithFrame:CGRectMake(0, [ApplicationStyle navigationBarHeight]+[ApplicationStyle spaceInset], [ApplicationStyle sidebarWidth], [ApplicationStyle buttonHeight])];
    [light setTitle:@"Light" forState:UIControlStateNormal];
    [light setTag:SidebarOptionLight];
    [light addTarget:self action:@selector(switchToViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:light];
    
    UIButton *ac = [[UIButton alloc]initWithFrame:CGRectMake(0, light.bottomOffset+[ApplicationStyle spaceInset], [ApplicationStyle sidebarWidth], [ApplicationStyle buttonHeight])];
    [ac setTitle:@"Air Condition" forState:UIControlStateNormal];
    [ac setTag:SidebarOptionAirCondition];
    [ac addTarget:self action:@selector(switchToViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ac];
    
    UIButton *door = [[UIButton alloc]initWithFrame:CGRectMake(0, ac.bottomOffset+[ApplicationStyle spaceInset], [ApplicationStyle sidebarWidth], [ApplicationStyle buttonHeight])];
    [door setTitle:@"Door" forState:UIControlStateNormal];
    [door setTag:SidebarOptionDoor];
    [door addTarget:self action:@selector(switchToViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:door];
}

- (void)switchToViewController:(UIButton *)sender
{
    UIViewController *vc;
    if (sender.tag == SidebarOptionLight) {
        vc = [LightViewController new];
    } else if (sender.tag == SidebarOptionAirCondition) {
        vc = [ACViewController new];
    } else if (sender.tag == SidebarOptionDoor) {
        vc = [DoorViewController new];
    }
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    IIViewDeckController *deckController = [IIViewDeckController sharedInstance];
    deckController.centerController = navVC;
    if (![deckController isSideClosed:IIViewDeckLeftSide]) {
        [deckController toggleLeftViewAnimated:YES];
    }
}

@end
