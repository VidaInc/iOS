//
//  BeaconTableViewCell.m
//  VidaHome
//
//  Created by Wenqi Zhou on 2015-01-07.
//  Copyright (c) 2015 Vida. All rights reserved.
//

#import "BeaconTableViewCell.h"

@interface BeaconTableViewCell () {
    CGFloat width;
    CGFloat height;
}

@end

@implementation BeaconTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        width = self.frame.size.width;
        height = self.frame.size.height;
        
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    self.rssi = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width/2, height)];
    [self addSubview:self.rssi];
    self.temperature = [[UILabel alloc]initWithFrame:CGRectMake(width/2, 0, width/2, height)];
    [self addSubview:self.temperature];
}

@end
