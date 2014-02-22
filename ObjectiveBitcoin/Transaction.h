//
//  Transaction.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/15/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject


@property (strong, nonatomic) NSNumber *amount;
@property (strong, nonatomic) NSNumber *confirmations;
@property (strong, nonatomic) NSString *blockHash;
@property (strong, nonatomic) NSNumber *blockIndex;
@property (strong, nonatomic) NSDate *blockTime;
@property (strong, nonatomic) NSString *txId;
@property (strong, nonatomic) NSDate *time;
@property (strong, nonatomic) NSDate *timeReceived;
@property (strong, nonatomic) NSArray *details;


- (id)initWithDictionary:(NSDictionary *)transactionDict;

- (NSString *)description;

@end
