//
//  ABLightManager.h
//  ABLightSDK
//
//  Created by liaojinhua on 14-9-18.
//  Copyright (c) 2014年 AprilBrother. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ABLightManager;
@class ABLight;

/**
 
 * The ABLightManagerDelegate protocol defines the delegate methods
   to respond for related events.
 
 */

@protocol ABLightManagerDelegate <NSObject>

@optional
/**
 * Delegate method invoked during scan.
 * Allows to retrieve single April light object
 * represented with ABLight objects.
 *
 * @param manager April light manager
 * @param light Discovered April light as ABLight
 *
 * @return void
 */
- (void)lightManager:(ABLightManager *)manager
    didDiscoverLights:(NSArray *)lights;

@end


/**
 
 * The ABLightManager class defines the interface for scan April lights.
 * You use an instance of this class to scan April light
 
 */
@interface ABLightManager : NSObject

/**
 *  delegate
 *
 *    Delegate of ABLightManager.
 *    Called when the relevant events occurent
 */
@property (nonatomic, weak) id<ABLightManagerDelegate> delegate;

/**
 * Start discover April light.
 * Call lightManager:didDiscoverLight: when discovered.
 * Will remove all discovered lights when this method be called.
 * @see ABLightManagerDelegate
 *
 * @return void
 */
- (void)startDiscoverLight;

/**
 * Stop discover April light
 *
 * @return void
 */
- (void)stopDiscoverLight;

@end
