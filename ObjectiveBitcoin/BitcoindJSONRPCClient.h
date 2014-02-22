//
//  BitcoindJSONRPCClient.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/22/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BitcoindJSONRPCClient : NSObject


+(void)callMethod:(NSString *)methodName
               url:(NSString *)hostURL
        withParams:(NSArray *)params
          username:(NSString *)username
          password:(NSString *)password
        useTestnet:(Boolean)isTestnet
           success:(void (^)(NSDictionary *jsonData))success
           failure:(void (^)(NSURLResponse *error))failure;


+(NSString *)encodeUsernamePassword:(NSString *)username
                            password:(NSString *)password;


+(NSString *)createParamsString:(NSArray *)params;


@end
