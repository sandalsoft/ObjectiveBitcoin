//
//  BitcoindJSONRPCClient.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/22/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BitcoindJSONRPCClient : NSObject

@property (strong, nonatomic) NSString *hostUrl;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;



+(BitcoindJSONRPCClient *)sharedClientWithHost:(NSString *)host
              port:(NSString *)port
          username:(NSString *)username
          password:(NSString *)password;



-(void)callMethod:(NSString *)methodName
        withParams:(NSArray *)params
          success:(void (^)(NSDictionary *jsonData))success
           failure:(void (^)(NSError *error))failure;


-(NSString *)encodeUsernamePassword:(NSString *)username
                            password:(NSString *)password;


-(NSString *)createParamsString:(NSArray *)params;


@end
