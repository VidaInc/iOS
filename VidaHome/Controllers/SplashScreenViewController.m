//
//  SplashScreenViewController.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "AppDelegate.h"

@interface SplashScreenViewController () {
    CGFloat width, height;
}

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self buildUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)buildUI
{
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    [self.view setBackgroundColor:[ApplicationStyle backgroundColor]];
    
    UILabel *logo = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, width, [ApplicationStyle buttonHeight])];
    [logo setText:@"Vida"];
    [logo setFont:[UIFont fontWithType:FontTypeMedium andSize:[ApplicationStyle extraLargeTextSize]]];
    [logo setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:logo];
    
    UIButton *signUp = [[UIButton alloc] initWithFrame:CGRectMake(0, height/2 + [ApplicationStyle buttonSpaceInset], [ApplicationStyle buttonWidth], [ApplicationStyle buttonHeight])];
    [signUp centerInWidth:width];
    [signUp setBackgroundColor:[UIColor whiteColor]];
    [signUp.layer setCornerRadius:[ApplicationStyle buttonHeight]/2];
    [signUp.layer setMasksToBounds:YES];
    [signUp setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:signUp];
    
    UIButton *signIn = [[UIButton alloc] initWithFrame:CGRectMake(0, signUp.bottomOffset+[ApplicationStyle buttonSpaceInset], [ApplicationStyle buttonWidth], [ApplicationStyle buttonHeight])];
    [signIn centerInWidth:width];
    [signIn setBackgroundColor:[UIColor whiteColor]];
    [signIn.layer setCornerRadius:[ApplicationStyle buttonHeight]/2];
    [signIn.layer setMasksToBounds:YES];
    [signIn setTitle:@"Sign In" forState:UIControlStateNormal];
    [signIn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:signIn];
    
    UIButton *skip = [[UIButton alloc] initWithFrame:CGRectMake(0, signIn.bottomOffset+[ApplicationStyle buttonSpaceInset], [ApplicationStyle buttonWidth], [ApplicationStyle buttonHeight])];
    [skip addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    [skip centerInWidth:width];
    [skip setBackgroundColor:[UIColor whiteColor]];
    [skip.layer setCornerRadius:[ApplicationStyle buttonHeight]/2];
    [skip.layer setMasksToBounds:YES];
    [skip setTitle:@"Skip" forState:UIControlStateNormal];
    [skip setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:skip];
}

- (void)skip
{
    [((AppDelegate *)[[UIApplication sharedApplication]delegate]) switchToViewDeckRootViewController];
}

@end
