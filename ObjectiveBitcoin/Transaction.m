//
//  Transaction.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/15/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction



- (id)initWithDictionary:(NSDictionary *)transactionDict {
    if ((self = [super init])) {
        _Amount = [transactionDict valueForKey:@"amount"];
        _Confirmations = [transactionDict valueForKey:@"confirmations"];
        _BlockHash = [transactionDict valueForKey:@"blockhash"];
        _BlockIndex = [transactionDict valueForKey:@"blockindex"];
        _BlockTime = [NSDate dateWithTimeIntervalSince1970:[[transactionDict valueForKey:@"blocktime"] doubleValue]];
        _TxId = [transactionDict valueForKey:@"txid"];
        _Time = [NSDate dateWithTimeIntervalSince1970:[[transactionDict valueForKey:@"time"] doubleValue]];
        _TimeReceived = [NSDate dateWithTimeIntervalSince1970:[[transactionDict valueForKey:@"timereceived"] doubleValue]];
        _Details = [transactionDict valueForKey:@"details"];
    }
    return self;
};

- (NSString *)description {
    return [NSString stringWithFormat:@"Amount: %@\n Confirmations: %@\n BlockHash: %@\n BlockIndex: %@\n BlockTime: %@\n TxId: %@\n Time: %@\n TimeReceived: %@\n Details: %@\n", self.Amount, self.Confirmations, self.BlockHash, self.BlockIndex, self.BlockTime, self.TxId, self.Time, self.TimeReceived, self.Details];
}


@end
