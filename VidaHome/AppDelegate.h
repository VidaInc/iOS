//
//  AppDelegate.h
//  VidaHome
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)switchToSplashScreenRootViewController;
-(void)switchToViewDeckRootViewController;

@end

