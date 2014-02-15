//
//  Transaction.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/2/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RawTransaction : NSObject

@property (strong, nonatomic) NSString *Hex;
@property (strong, nonatomic) NSString *TransactionId;
@property (strong, nonatomic) NSNumber *Version;
@property (strong, nonatomic) NSNumber *LockTime;
@property (strong, nonatomic) NSArray *VIn;
@property (strong, nonatomic) NSArray *VOut;
@property (strong, nonatomic) NSString *BlockHash;
@property (strong, nonatomic) NSNumber *Confirmations;
@property (strong, nonatomic) NSDate *Time;
@property (strong, nonatomic) NSDate *BlockTime;


@end
