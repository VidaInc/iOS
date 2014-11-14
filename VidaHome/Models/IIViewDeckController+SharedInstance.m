//
//  IIViewDeckController+SharedInstance.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "IIViewDeckController+SharedInstance.h"

static IIViewDeckController *sharedInstance = nil;

@implementation IIViewDeckController (SharedInstance)

+ (instancetype)sharedInstance
{
    @synchronized(self)
    {
        return (sharedInstance ? : (sharedInstance = [self new]));
    }
}

@end
