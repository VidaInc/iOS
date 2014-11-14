//
//  NetworkManager.m
//  Vida
//
//  Created by Wenqi Zhou on 2014-10-28.
//  Copyright (c) 2014 Vida. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>
#import <AFNetworkActivityIndicatorManager.h>

#ifdef DEBUG
static const int afnetworkingLogLevel = AFLoggerLevelDebug;
#else
static const int afnetworkingLogLevel = AFLoggerLevelError;
#endif

static NetworkManager *sharedInstance = nil;

@implementation NetworkManager {
    AFHTTPRequestOperationManager *manager;
}

+ (instancetype)sharedInstance {
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[NetworkManager alloc]init];
        }
        return sharedInstance;
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createManagerWithDefaultBaseURL];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        [[AFNetworkActivityLogger sharedLogger] startLogging];
        [[AFNetworkActivityLogger sharedLogger] setLevel:afnetworkingLogLevel];
    }
    return self;
}


-(void)createManagerWithDefaultBaseURL {
    [self createManagerWithBaseURL:[ApplicationStyle baseURLString]];
}

-(void)createManagerWithBaseURL:(NSString*)baseURLString {
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = TIME_OUT;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
}

-(void)getRequest:(NSString*)urlString
       parameters:(NSDictionary*)parameters
          success:(void(^)(id responseObject))successBlock
          failure:(void(^)(NSError *error))failureBlock {
    
    [manager GET:urlString
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
             //[ResponseErrorManager handleAuthenticationFailures:error];
             failureBlock(error);
         }];
}

-(void)postRequest:(NSString*)urlString
        parameters:(NSDictionary*)parameters
           success:(void(^)(id responseObject))successBlock
           failure:(void(^)(NSError *error))failureBlock {
    
    [manager POST:urlString
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              successBlock(responseObject);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              //[ResponseErrorManager handleAuthenticationFailures:error];
              failureBlock(error);
          }];

}

-(void)putRequest:(NSString*)urlString
       parameters:(NSDictionary*)parameters
          success:(void(^)(id responseObject))successBlock
          failure:(void(^)(NSError *error))failureBlock {

    [manager PUT:urlString
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
             //[ResponseErrorManager handleAuthenticationFailures:error];
             failureBlock(error);
         }];
}

-(void)deleteRequest:(NSString*)urlString
          parameters:(NSDictionary*)parameters
             success:(void(^)(id responseObject))successBlock
             failure:(void(^)(NSError *error))failureBlock {

    [manager DELETE:urlString
         parameters:parameters
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                successBlock(responseObject);
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error){
                //[ResponseErrorManager handleAuthenticationFailures:error];
                failureBlock(error);
            }];
}

@end
