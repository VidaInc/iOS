//
//  AppDelegate.m
//  VidaHome
//
//  Created by Wenqi Zhou on 2014-11-14.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "AppDelegate.h"
#import "SplashScreenViewController.h"
#import "SideBarViewController.h"
#import "LightViewController.h"
#import "IIViewDeckController+SharedInstance.h"
#import <FYX/FYX.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Gimbal
    [FYX setAppId:@"dbbb6562c77b2c8433992e0abe12575ba6f86aadd8cdc1e132652da68e1c277c"
        appSecret:@"8ccecb68882556f6fef156cb64e4c941c11f59b5c43cf01382ea5bfe4e22f49a"
      callbackUrl:@"vidahome://authcode"];
    //Initialize styles
    [ApplicationStyle initializeApplicationStyle];
    [self setWindow:[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]]];
    
    [self switchToSplashScreenRootViewController];
    
    return YES;
}

-(void)switchToSplashScreenRootViewController
{
    SplashScreenViewController *viewController = [SplashScreenViewController new];
    //[viewController setShouldShowContentsWithAnimation:YES];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:viewController];
    [navController.navigationBar setTranslucent:YES];
    
    [self.window setRootViewController: navController];
    [self.window setBackgroundColor:[ApplicationStyle backgroundColor]];
    [self.window makeKeyAndVisible];
}

-(void)switchToViewDeckRootViewController
{
    IIViewDeckController *viewDeckController = [IIViewDeckController sharedInstance];
    SideBarViewController *menuVc;
    if (viewDeckController.leftController) {
        UINavigationController *navViewController = (UINavigationController *)viewDeckController.leftController;
        menuVc = navViewController.viewControllers[0];
    } else {
        LightViewController *viewController = [LightViewController new];
        //[venuViewController setNoRefresh:NO];
        
        UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        //[navViewController.navigationBar setTranslucent:YES];
        
        menuVc = [[SideBarViewController alloc] init];
        UINavigationController *leftViewController  = [[UINavigationController alloc] initWithRootViewController:menuVc];
        
        [viewDeckController setCenterController:navViewController];
        [viewDeckController setLeftController:leftViewController];
        [viewDeckController setRightController:nil];
        
        [viewDeckController.view setBackgroundColor:[ApplicationStyle backgroundColor]];
        [viewDeckController setLeftSize:[UIScreen mainScreen].bounds.size.width - [ApplicationStyle sidebarWidth]];
    }
    
    viewDeckController.centerController.view.alpha = 0;
    [UIView transitionWithView:self.window duration:ANIMATION_DURATION options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        [self.window setRootViewController: viewDeckController];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            viewDeckController.centerController.view.alpha = 1;
        } completion:^(BOOL finished) {
            [self.window setBackgroundColor:[ApplicationStyle backgroundColor]];
            [self.window makeKeyAndVisible];
        }];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
