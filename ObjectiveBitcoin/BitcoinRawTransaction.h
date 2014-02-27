//
//  Transaction.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/2/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BitcoinRawTransaction : NSObject

@property (strong, nonatomic) NSString *hex;
@property (strong, nonatomic) NSString *transactionId;
@property (strong, nonatomic) NSNumber *version;
@property (strong, nonatomic) NSNumber *lockTime;
@property (strong, nonatomic) NSArray *vIn;
@property (strong, nonatomic) NSArray *vOut;
@property (strong, nonatomic) NSString *blockHash;
@property (strong, nonatomic) NSNumber *confirmations;
@property (strong, nonatomic) NSDate *time;
@property (strong, nonatomic) NSDate *blockTime;

- (id)initWithDictionary:(NSDictionary *)rawTransactionDict;

- (NSString *)description;

@end
