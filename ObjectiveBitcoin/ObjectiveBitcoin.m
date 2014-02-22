//
//  ObjectiveBitcoin.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "ObjectiveBitcoin.h"
#import "BitcoindJSONRPCClient.h"


@implementation ObjectiveBitcoin

+(void)getInfo:(void (^)(BitcoindInfo *info))success
       failure:(void (^)(NSError *error))failure {

    [BitcoindJSONRPCClient callMethod:@"getinfo" url:@"http://dsv.sndl.io:18332/" withParams:@[] username:@"u" password:@"p" useTestnet:YES success:^(NSDictionary *jsonData) {
        NSDictionary *infoDict = [[NSDictionary alloc] initWithDictionary:[jsonData objectForKey:@"result"]];
        success([[BitcoindInfo alloc] initWithDictionary:infoDict]);
    } failure:^(NSURLResponse *responseError) {
        NSError *error = [NSError errorWithDomain:@"getInfo" code:666 userInfo:@{@"errorkey":@"errorinfo"}];
        failure(error);
    }];
}

+(void)getTransaction:(NSString *)transactionId
              success:(void (^)(Transaction *transaction))success
              failure:(void (^)(NSError *error))failure {
    
   }

+(void)getRawTransaction:(NSString *)transactionId
              success:(void (^)(RawTransaction *rawTransaction))success
              failure:(void (^)(NSError *error))failure {
    
   }

+(void)validateAddress:(NSString *)transactionId
               success:(void (^)(NSDictionary *addressInfo))success
               failure:(void (^)(NSError *error))failure {
   }

@end
