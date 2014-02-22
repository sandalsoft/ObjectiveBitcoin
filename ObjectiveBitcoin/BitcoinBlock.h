//
//  Block.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BitcoinBlock : NSObject

@property (weak, nonatomic) NSString *Hash;
@property (weak, nonatomic) NSNumber *Confirmations;
@property (weak, nonatomic) NSNumber *Size;
@property (weak, nonatomic) NSNumber *Height;
@property (weak, nonatomic) NSNumber *Version;
@property (weak, nonatomic) NSString *MerkleRoot;
@property (weak, nonatomic) NSArray *Transactions;
@property (weak, nonatomic) NSDate *Time;
@property (weak, nonatomic) NSNumber *Nonce;
@property (weak, nonatomic) NSString *Bits;
@property (weak, nonatomic) NSNumber *Difficulty;
@property (weak, nonatomic) NSString *PreviousBlockHash;


- (id)initWithDictionary:(NSDictionary *)blockDict;


@end
