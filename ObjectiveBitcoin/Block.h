//
//  Block.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Block : NSObject

@property (strong, nonatomic) NSString *Hash;
@property (strong, nonatomic) NSNumber *Confirmations;
@property (strong, nonatomic) NSNumber *Size;
@property (strong, nonatomic) NSNumber *Height;
@property (strong, nonatomic) NSNumber *Version;
@property (strong, nonatomic) NSString *MerkleRoot;
@property (strong, nonatomic) NSArray *Transactions;
@property (strong, nonatomic) NSDate *Time;
@property (strong, nonatomic) NSNumber *Nonce;
@property (strong, nonatomic) NSString *Bits;
@property (strong, nonatomic) NSNumber *Difficulty;
@property (strong, nonatomic) NSString *PreviousBlockHash;

@end
