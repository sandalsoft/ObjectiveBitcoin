//
//  Block.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BitcoinBlock : NSObject

@property (weak, nonatomic) NSString *blockHash;
@property (weak, nonatomic) NSNumber *confirmations;
@property (weak, nonatomic) NSNumber *size;
@property (weak, nonatomic) NSNumber *height;
@property (weak, nonatomic) NSNumber *version;
@property (weak, nonatomic) NSString *merkleRoot;
@property (weak, nonatomic) NSArray *transactions;
@property (weak, nonatomic) NSDate *time;
@property (weak, nonatomic) NSNumber *nonce;
@property (weak, nonatomic) NSString *bits;
@property (weak, nonatomic) NSNumber *difficulty;
@property (weak, nonatomic) NSString *previousBlockHash;


- (id)initWithDictionary:(NSDictionary *)blockDict;

- (NSString *)description;

@end
