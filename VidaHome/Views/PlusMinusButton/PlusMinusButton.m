//
//  PlusMinusButton.m
//  Alfred
//
//  Created by Nabiilah Rajabalee on 12/18/2013.
//  Copyright (c) 2013 VRG Interactive. All rights reserved.
//

#import "PlusMinusButton.h"
#import "ApplicationStyle.h"

#define BUTTON_WIDTH 40.0f
#define BUTTON_HEIGHT 40.0f

@implementation PlusMinusButton

+ (PlusMinusButton*)initPlusButton {
    PlusMinusButton *button = [[PlusMinusButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [button setImage:[UIImage imageNamed:@"plusButton"] forState:UIControlStateNormal];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    return button;
}

+ (PlusMinusButton*)initMinusButton {
    PlusMinusButton *button = [[PlusMinusButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [button setImage:[UIImage imageNamed:@"minusButton"] forState:UIControlStateNormal];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    return button;
}

@end
