//
//  CenterViewController.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) IIViewDeckController *deckVC;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation CenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"navigationSB"];
    [ApplicationStyle customizeLeftButton:self hander:@selector(toggleDeck) withImage:image];
    self.deckVC = [IIViewDeckController sharedInstance];
    self.deckVC.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ([IIViewDeckController sharedInstance]).panningGestureDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController didChangeOffset:(CGFloat)offset orientation:(IIViewDeckOffsetOrientation)orientation panning:(BOOL)panning
{
    //NSLog(@"%f", offset);
    if (offset <= [ApplicationStyle sidebarWidth]) {
        CGRect frame = viewDeckController.leftController.view.frame;
        frame.origin.x = (-[ApplicationStyle sidebarWidth]+offset)*0.35;
        viewDeckController.leftController.view.frame = frame;
    }
}

-(void)toggleDeck
{
    [self.deckVC toggleLeftViewAnimated:YES];
}

-(void)viewDeckController:(IIViewDeckController *)viewDeckController didOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated
{
    [self disableUserInteraction];
    if (!self.tap) {
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandler:)];
        [self.view addGestureRecognizer:self.tap];
    }
}

-(void)viewDeckController:(IIViewDeckController *)viewDeckController didCloseViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated
{
    [self enableUserInteraction];
    [self.view removeGestureRecognizer:self.tap];
    self.tap = nil;
}

-(BOOL)viewDeckController:(IIViewDeckController *)viewDeckController shouldOpenViewSide:(IIViewDeckSide)viewDeckSide
{
    return YES;
}

-(void)tapHandler: (UITapGestureRecognizer *)tap
{
    if (![self.deckVC isSideClosed:IIViewDeckLeftSide]) {
        [self.deckVC toggleLeftViewAnimated:YES];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

-(void)disableUserInteraction{}
-(void)enableUserInteraction{}

@end
