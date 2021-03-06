//
//  CenterViewController.h
//  Vida
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController+SharedInstance.h"

@protocol CenterViewControllerProtocol <NSObject>

@required
- (void)disableUserInteraction;
- (void)enableUserInteraction;

@end

@interface CenterViewController : UIViewController <IIViewDeckControllerDelegate>

@end
