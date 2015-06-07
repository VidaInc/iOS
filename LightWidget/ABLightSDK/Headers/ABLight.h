//
//  ABLight.h
//  ABLightSDK
//
//  Created by liaojinhua on 14-9-18.
//  Copyright (c) 2014年 AprilBrother. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreBluetooth;

/**
 *    callback method.
 *
 *    @param error nil or specific error.
 */
typedef void(^ABCompletionBlock)(NSError* error);

@class ABLight;

/**
 
 * ABLightDelegate defines light connection delegate mathods. Connection is
 * asynchronous operation so you need to be prepared that eg. 
 * lightDidDisconnected:withError method can be invoked without previous action.
 
 */

@protocol ABLightDelegate <NSObject>

@optional
/**
 * Delegate method that light did connected with error.
 * if error is not nil which means light didn't be connected
 * or light was connected
 *
 * @param light reference to ABLight object
 * @param error light connect failed error or nil
 *
 * @return void
 */
- (void)lightDidConnected:(ABLight *)light withError:(NSError *)error;

/**
 * Delegate method that light did connected with error.
 *
 * or light was connected
 *
 * @param light reference to ABLight object
 * @param the reason of light disconnected or nil
 *
 * @return void
 */
- (void)lightDidDisconnected:(ABLight *)light withError:(NSError *)error;

@end

/**
 
 * ABLight defines the property of light and method to communicate with light
 
 */

@interface ABLight : NSObject

/// @name Publicly available properties

/**
 *  peripheral
 *
 *    CBPeripheral object of the light.
 *
 */
@property (nonatomic, strong) CBPeripheral *peripheral;


/**
 *  delegate
 *
 *    Delegate of ABLight, used to call lightDidConnected:withError and
 *    lightDidDisconnected:withError.
 *
 */
@property (nonatomic, weak) id<ABLightDelegate> delegate;

/**
 *  currentLight
 *
 *    Current light value
 *
 */
@property (nonatomic) NSUInteger currentLight;

/**
 * Init mehtod of ABLight wiht CBPeripheral object.
 *
 * @param peripheral CBPeripheral object
 * @return void
 */
- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral;

/**
 * Connect to ABLight to communicate with it
 *
 * @return void
 */
- (void)connect;

/**
 * Disconnect withe ABLight
 *
 * @return void
 */
- (void)disconnect;

/**
 * Modify the light value of ABLight 
 *
 * @param lightValue The value to be set, the range is 0-255
 * @param completion The callback when complete the event
 *
 * @return void
 */
- (void)setLightValue:(NSInteger)lightValue withCompletion:(ABCompletionBlock)completion;

@end
