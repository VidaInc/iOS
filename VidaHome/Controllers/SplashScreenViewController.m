//
//  SplashScreenViewController.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "SplashScreenViewController.h"

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
    
    UIButton *signUp = [[UIButton alloc] initWithFrame:CGRectMake(0, height/2 + [ApplicationStyle buttonSpaceInset], [ApplicationStyle buttonWidth], [ApplicationStyle buttonHeight])];
    [signUp centerInWidth:width];
    [signUp setBackgroundColor:[UIColor whiteColor]];
    [signUp.layer setCornerRadius:[ApplicationStyle buttonHeight]/2];
    [signUp.layer setMasksToBounds:YES];
    [signUp setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.view addSubview:signUp];
    
    UIButton *signIn = [[UIButton alloc] initWithFrame:CGRectMake(0, signUp.bottomOffset+[ApplicationStyle buttonSpaceInset], [ApplicationStyle buttonWidth], [ApplicationStyle buttonHeight])];
    [signIn centerInWidth:width];
    [signIn setBackgroundColor:[UIColor whiteColor]];
    [signIn.layer setCornerRadius:[ApplicationStyle buttonHeight]/2];
    [signIn.layer setMasksToBounds:YES];
    [signIn setTitle:@"Sign In" forState:UIControlStateNormal];
    [self.view addSubview:signIn];
    
    
}

@end
