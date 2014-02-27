//
//  Transaction.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/15/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "BitcoinTransaction.h"

@implementation BitcoinTransaction



- (id)initWithDictionary:(NSDictionary *)transactionDict {
    if ((self = [super init])) {
        _amount = [transactionDict valueForKey:@"amount"];
        _confirmations = [transactionDict valueForKey:@"confirmations"];
        _blockHash = [transactionDict valueForKey:@"blockhash"];
        _blockIndex = [transactionDict valueForKey:@"blockindex"];
        _blockTime = [NSDate dateWithTimeIntervalSince1970:[[transactionDict valueForKey:@"blocktime"] doubleValue]];
        _txId = [transactionDict valueForKey:@"txid"];
        _time = [NSDate dateWithTimeIntervalSince1970:[[transactionDict valueForKey:@"time"] doubleValue]];
        _timeReceived = [NSDate dateWithTimeIntervalSince1970:[[transactionDict valueForKey:@"timereceived"] doubleValue]];
        _details = [transactionDict valueForKey:@"details"];
    }
    return self;
};

- (NSString *)description {
    return [NSString stringWithFormat:@"Amount: %@\n Confirmations: %@\n BlockHash: %@\n BlockIndex: %@\n BlockTime: %@\n TxId: %@\n Time: %@\n TimeReceived: %@\n Details: %@\n", self.amount, self.confirmations, self.blockHash, self.blockIndex, self.blockTime, self.txId, self.time, self.timeReceived, self.details];
}


@end
