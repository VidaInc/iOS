//
//  ColorPickerViewController.m
//  VidaHome
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "ColorPickerViewController.h"
#import <NKOColorPickerView/NKOColorPickerView.h>

@interface ColorPickerViewController (){
    CGFloat width, height;
    UIButton *change;
}

@end

@implementation ColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
}

-(NSString *)title {return @"Light Color";}

-(void)buildUI
{
    [self.view setBackgroundColor:[ApplicationStyle backgroundColor]];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    NKOColorPickerView *pickerView = [[NKOColorPickerView alloc]initWithFrame:CGRectMake(0, 0, 290, 400) color:[UIColor blueColor] andDidChangeColorBlock:^(UIColor *color) {
        [change setBackgroundColor:color];
    }];
    [pickerView centerInWidth:width];
    [pickerView centerInHeight:height];
    [self.view addSubview:pickerView];
    
    change = [[UIButton alloc] initWithFrame:CGRectMake(0, pickerView.bottomOffset, [ApplicationStyle buttonWidth], [ApplicationStyle buttonHeight])];
    [change addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    [change centerInWidth:width];
    [change setBackgroundColor:[UIColor blueColor]];
    [change.layer setCornerRadius:[ApplicationStyle buttonHeight]/2];
    [change.layer setMasksToBounds:YES];
    [change setTitle:@"Change" forState:UIControlStateNormal];
    [change setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:change];
}

-(void)changeColor:(UIButton *)sender
{
    UIColor *color = sender.backgroundColor;
    NSString *hexString = [NSString stringWithFormat:@"#%@",[color hexStringFromColor]];
    [[NetworkManager sharedInstance] postRequest:@"/api/light/1" parameters:@{@"ON":@YES, @"color":hexString} success:^(id responseObject) {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

@end
