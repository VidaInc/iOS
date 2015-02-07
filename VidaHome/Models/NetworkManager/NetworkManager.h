//
//  NetworkManager.h
//  Vida
//
//  Created by Wenqi Zhou on 2014-10-28.
//  Copyright (c) 2014 Vida. All rights reserved.
//

@interface NetworkManager : NSObject

+ (instancetype)sharedInstance;

-(void)getRequest:(NSString*)urlString
       parameters:(NSDictionary*)parameters
          success:(void(^)(id responseObject))successBlock
          failure:(void(^)(NSError *error))failureBlock;
-(void)postRequest:(NSString*)urlString
        parameters:(NSDictionary*)parameters
           success:(void(^)(id responseObject))successBlock
           failure:(void(^)(NSError *error))failureBlock;
-(void)putRequest:(NSString*)urlString
       parameters:(NSDictionary*)parameters
          success:(void(^)(id responseObject))successBlock
          failure:(void(^)(NSError *error))failureBlock;
-(void)deleteRequest:(NSString*)urlString
          parameters:(NSDictionary*)parameters
             success:(void(^)(id responseObject))successBlock
             failure:(void(^)(NSError *error))failureBlock;

-(void)createManagerWithBaseURL:(NSString*)baseURLString;
@end
