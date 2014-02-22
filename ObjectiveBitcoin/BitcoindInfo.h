//
//  BitcoindInfo.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/22/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BitcoindInfo : NSObject

@property (strong, nonatomic) NSNumber *version;
@property (strong, nonatomic) NSNumber *protocolVersion;
@property (strong, nonatomic) NSNumber *walletVersion;
@property (strong, nonatomic) NSNumber *balance;
@property (strong, nonatomic) NSNumber *blocks;
@property (strong, nonatomic) NSNumber *timeOffset;
@property (strong, nonatomic) NSNumber *connections;
@property (strong, nonatomic) NSString *proxy;
@property (strong, nonatomic) NSNumber *difficulty;
@property (assign, nonatomic) Boolean isTestnet;
@property (strong, nonatomic) NSNumber *keyPoolOldest;
@property (strong, nonatomic) NSNumber *keyPoolSize;
@property (strong, nonatomic) NSNumber *payTxFee;
@property (strong, nonatomic) NSNumber *errors;


- (id)initWithDictionary:(NSDictionary *)infoDict;
- (NSString *)description;

@end
