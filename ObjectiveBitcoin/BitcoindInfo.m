//
//  BitcoindInfo.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/22/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "BitcoindInfo.h"

@implementation BitcoindInfo


- (id)initWithDictionary:(NSDictionary *)infoDict {
    if ((self = [super init])) {
        _version = [infoDict valueForKey:@"version"];
        _protocolVersion= [infoDict valueForKey:@"protocolversion"];
        _walletVersion= [infoDict valueForKey:@"walletversion"];
        _balance = [infoDict valueForKey:@"balance"];
        _blocks = [infoDict valueForKey:@"blocks"];
        _timeOffset = [infoDict valueForKey:@"timeoffset"];
        _connections = [infoDict valueForKey:@"connections"];
        _proxy = [infoDict valueForKey:@"proxy"];
        _difficulty = [infoDict valueForKey:@"difficulty"];
        _keyPoolOldest = [infoDict valueForKey:@"keypoololdest"];
        _keyPoolSize = [infoDict valueForKey:@"keypoolsize"];
        _payTxFee = [infoDict valueForKey:@"paytxfee"];
        _errors = [infoDict valueForKey:@"errors"];
        
        if ([[infoDict valueForKey:@"testnet"] boolValue])
            _isTestnet = YES;
        else
            _isTestnet = NO;
    }
    return self;
};

- (NSString *)description {
    return [NSString stringWithFormat:@"Version: %@\n ProtocolVersion: %@\n WalletVersion: %@\n Balance: %@\n Blocks: %@\n TimeOffset: %@\n Connections: %@\n Proxy: %@\n Difficulty: %@\n KeyPoolOldest: %@\n KeyPoolsize: %@\n PayTxFee: %@\n Errors: %@\n", self.version, self.protocolVersion, self.walletVersion, self.balance, self.blocks, self.timeOffset, self.connections, self.proxy, self.difficulty, self.keyPoolOldest, self.keyPoolSize, self.payTxFee, self.errors];
}

@end
