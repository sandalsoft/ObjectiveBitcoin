//
//  ObjectiveBitcoin.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "ObjectiveBitcoin.h"


@implementation ObjectiveBitcoin


-(id)initWithHost:(NSString *)host
         port:(NSString *)port
     username:(NSString *)username
     password:(NSString *)password
    isTestnet:(Boolean)isTestnet {
    
    self = [super init];
    if (self) {
        _bitcoindClient = [BitcoindJSONRPCClient sharedClientWithHost:host port:port username:username password:password isTestnet:isTestnet];
    }
    return self;
}


-(void)getInfo:(void (^)(BitcoindInfo *info))success
       failure:(void (^)(NSError *error))failure {
    
    [self.bitcoindClient callMethod:@"getinfo" withParams:@[] success:^(NSDictionary *jsonData) {
        NSDictionary *infoDict = [[NSDictionary alloc] initWithDictionary:[jsonData objectForKey:@"result"]];
        success([[BitcoindInfo alloc] initWithDictionary:infoDict]);
    } failure:^(NSURLResponse *responseError) {

        NSError *error = [NSError errorWithDomain:@"getInfo" code:666 userInfo:@{@"errorkey":@"errorinfo"}];
        failure(error);
    }];
}

-(void)getAccountAddress:(NSString *)account
                 success:(void (^)(NSString *address))success
                 failure:(void (^)(NSError *error))failure {
    
    [self.bitcoindClient callMethod:@"getaccountaddress" withParams:@[@"test"] success:^(NSDictionary *jsonData) {
        NSString *address = [jsonData valueForKey:@"result"];
        success(address);
    } failure:^(NSURLResponse *resposeError) {
        NSError *error = [NSError errorWithDomain:@"getInfo" code:666 userInfo:@{@"errorkey":@"errorinfo"}];
        failure(error);
    }];
}

-(void)getTransaction:(NSString *)transactionId
              success:(void (^)(Transaction *transaction))success
              failure:(void (^)(NSError *error))failure {
    
   }

-(void)getRawTransaction:(NSString *)transactionId
              success:(void (^)(RawTransaction *rawTransaction))success
              failure:(void (^)(NSError *error))failure {
    
   }

-(void)validateAddress:(NSString *)transactionId
               success:(void (^)(NSDictionary *addressInfo))success
               failure:(void (^)(NSError *error))failure {
   }

@end
