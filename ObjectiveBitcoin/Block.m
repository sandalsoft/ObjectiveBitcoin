//
//  Block.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "Block.h"

@implementation Block

- (id)initWithDictionary:(NSDictionary *)blockDict {
    if ((self = [super init])) {
        _Hash = [blockDict valueForKey:@"hash"];
        _Confirmations = [blockDict valueForKey:@"confirmations"];
        _Size = [blockDict valueForKey:@"size"];
        _Height = [blockDict valueForKey:@"height"];
        _Version = [blockDict valueForKey:@"version"];
        _MerkleRoot = [blockDict valueForKey:@"merkleroot"];
        _Transactions = [blockDict valueForKey:@"tx"];
        _Time = [NSDate dateWithTimeIntervalSince1970:[[blockDict valueForKey:@"time"] doubleValue]];
        _Nonce = [blockDict valueForKey:@"nonce"];
        _Bits = [blockDict valueForKey:@"bits"];
        _Difficulty = [blockDict valueForKey:@"difficulty"];
        _PreviousBlockHash = [blockDict valueForKey:@"previousblockhash"];
    }
    
    return self;
    
};

@end
