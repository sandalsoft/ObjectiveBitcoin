//
//  Block.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "BitcoinBlock.h"

@implementation BitcoinBlock : NSObject 


- (id)initWithDictionary:(NSDictionary *)blockDict {
    if ((self = [super init])) {
        _hash = [blockDict valueForKey:@"hash"];
        _confirmations = [blockDict valueForKey:@"confirmations"];
        _size = [blockDict valueForKey:@"size"];
        _height = [blockDict valueForKey:@"height"];
        _version = [blockDict valueForKey:@"version"];
        _merkleRoot = [blockDict valueForKey:@"merkleroot"];
        _transactions = [blockDict valueForKey:@"tx"];
        _time = [NSDate dateWithTimeIntervalSince1970:[[blockDict valueForKey:@"time"] doubleValue]];
        _nonce = [blockDict valueForKey:@"nonce"];
        _bits = [blockDict valueForKey:@"bits"];
        _difficulty = [blockDict valueForKey:@"difficulty"];
        _previousBlockHash = [blockDict valueForKey:@"previousblockhash"];
    }
    
    
    
    return self;
    
};

- (NSString *)description {
    return [NSString stringWithFormat:@"Hash: %@\n Confirmations: %@\n Size: %@\n Height: %@\n Version: %@\n MerkleRoot: %@\n Transactions: %@\n Time: %@\n None: %@\n Bits: %@\n Difficulty: %@\n PreviousBlockHash: %@\n", self.hash, self.confirmations, self.size, self.height, self.version, self.merkleRoot, self.transactions, self.time, self.nonce, self.bits, self.difficulty, self.previousBlockHash];
}


@end
