//
//  Transaction.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/2/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "RawTransaction.h"

@implementation RawTransaction


- (id)initWithDictionary:(NSDictionary *)rawTransactionDict {
    if ((self = [super init])) {
        _hex = [rawTransactionDict valueForKey:@"hex"];
        _transactionId = [rawTransactionDict valueForKey:@"txid"];
        _version = [rawTransactionDict valueForKey:@"version"];
        _lockTime = [rawTransactionDict valueForKey:@"locktime"];
        _vIn = [rawTransactionDict valueForKey:@"vin"];
        _vOut = [rawTransactionDict valueForKey:@""];
        _blockHash = [rawTransactionDict valueForKey:@"blockhash"];
        _confirmations = [rawTransactionDict valueForKey:@"confirmations"];
        _time = [rawTransactionDict valueForKey:@"time"];
        _blockTime = [rawTransactionDict valueForKey:@"blocktime"];
    }
    return self;
};

- (NSString *)description {
    return [NSString stringWithFormat:@"Hex: %@\n TransactionId: %@\n Version: %@\n LockTime: %@\n VIn: %@\n VOut: %@\n BlockHash: %@\n Confirmations: %@\n Time: %@\n BlockTime: %@\n", self.hex, self.transactionId, self.version, self.lockTime, self.vIn, self.vOut, self.blockHash, self.confirmations, self.time, self.blockTime];
}



@end
