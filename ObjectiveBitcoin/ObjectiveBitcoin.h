//
//  ObjectiveBitcoin.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "Transaction.h"
#import "RawTransaction.h"
#import "BitcoinBlock.h"
#import "BitcoindInfo.h"
#import "BitcoindJSONRPCClient.h"
#import "BitcoinAddress.h"





@interface ObjectiveBitcoin : NSObject

@property BitcoindJSONRPCClient *bitcoindClient;


-(id)initWithHost:(NSString *)host
         port:(NSString *)port
     username:(NSString *)username
     password:(NSString *)password
    isTestnet:(Boolean)isTestnet;


-(void)getInfo:(void (^)(BitcoindInfo *info))success
       failure:(void (^)(NSError *error))failure;

-(void)getAccountAddress:(NSString *)account
              success:(void (^)(BitcoinAddress *address))success
              failure:(void (^)(NSError *error))failure;


-(void)getTransaction:(NSString *)transactionId
              success:(void (^)(Transaction *transaction))success
              failure:(void (^)(NSError *error))failure;

-(void)getRawTransaction:(NSString *)transactionId
              success:(void (^)(RawTransaction *rawTransaction))success
              failure:(void (^)(NSError *error))failure;

-(void)validateAddress:(NSString *)transactionId
               success:(void (^)(NSDictionary *addressInfo))success
               failure:(void (^)(NSError *error))failure;

@end
