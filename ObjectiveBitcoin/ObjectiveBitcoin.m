//
//  ObjectiveBitcoin.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "ObjectiveBitcoin.h"
#import "AFNetworking.h"

@implementation ObjectiveBitcoin

+(void)getTransaction:(NSString *)transactionId
              success:(void (^)(Transaction *transaction))success
              failure:(void (^)(NSError *error))failure {
    
    [[AFHTTPSessionManager manager] GET:@"hi" parameters:@{@"param1" : @"value"}
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                    Transaction *tx = [[Transaction alloc] initWithDictionary:[[NSDictionary alloc] initWithDictionary:(NSDictionary *)responseObject]];
                                    success(tx);
                                }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    failure(error);
                                }];
}

+(void)getRawTransaction:(NSString *)transactionId
              success:(void (^)(RawTransaction *rawTransaction))success
              failure:(void (^)(NSError *error))failure {
    
    [[AFHTTPSessionManager manager] GET:@"hi" parameters:@{@"param1" : @"value"}
                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                    RawTransaction *rawTx = [[RawTransaction alloc] initWithDictionary:[[NSDictionary alloc] initWithDictionary:(NSDictionary *)responseObject]];
                                    success(rawTx);
                                }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    failure(error);
                                }];
}


@end
