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
         _Hex = [rawTransactionDict valueForKey:@"hex"];
        _TransactionId = [rawTransactionDict valueForKey:@"txid"];
        _Version = [rawTransactionDict valueForKey:@"version"];
        _LockTime = [rawTransactionDict valueForKey:@"locktime"];
        _VIn = [rawTransactionDict valueForKey:@"vin"];
        _VOut = [rawTransactionDict valueForKey:@""];
        _BlockHash = [rawTransactionDict valueForKey:@"blockhash"];
        _Confirmations = [rawTransactionDict valueForKey:@"confirmations"];
        _Time = [rawTransactionDict valueForKey:@"time"];
        _BlockTime = [rawTransactionDict valueForKey:@"blocktime"];
    }
    return self;
};

- (NSString *)description {
    return [NSString stringWithFormat:@"Hex: %@\n TransactionId: %@\n Version: %@\n LockTime: %@\n VIn: %@\n VOut: %@\n BlockHash: %@\n Confirmations: %@\n Time: %@\n BlockTime: %@\n", self.Hex, self.TransactionId, self.Version, self.LockTime, self.VIn, self.VOut, self.BlockHash, self.Confirmations, self.Time, self.BlockTime];
}



@end
