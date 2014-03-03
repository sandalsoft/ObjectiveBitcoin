//
//  ObjectiveBitcoin.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "ObjectiveBitcoin.h"

@implementation ObjectiveBitcoin

// init function instantiates BitcoindJSONRPCClient singleton.  We accept parameters needed to setup the client to make calls once, and reuse that instance.

-(id)initWithHost:(NSString *)host
         port:(NSString *)port
     username:(NSString *)username
     password:(NSString *)password {
    
    self = [super init];
    if (self) {
        _bitcoindClient = [BitcoindJSONRPCClient sharedClientWithHost:host port:port username:username password:password];
    }
    return self;
}


#pragma mark - bitciond methods

- (void)getAccountAddress:(NSString *)account
                  success:(void (^)(BitcoinAddress *address))success
                  failure:(void (^)(NSError *error))failure {
	[self.bitcoindClient callMethod:@"getaccountaddress" withParams:@[account] success: ^(NSDictionary *jsonData) {
	    NSString *addressString = [jsonData valueForKey:RESULT_BITCOIND_JSON_KEY];
	    BitcoinAddress *address = [[BitcoinAddress alloc] initWithString:addressString];
	    success(address);
	} failure: ^(NSError *error) {
	    failure(error);
	}];
}

-(void)getBalanceForAccount:(NSString *)account
          success:(void (^)(NSNumber *))success
          failure:(void (^)(NSError *))failure {
    
    // Be defensive about incoming params.  account could be nil
    if (!account)
        account = @"";

    [self getBalanceForAccount:account withMinimumConfirmations:[NSNumber numberWithInt:1] success:^(NSNumber *balance) {
        success(balance);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getBalanceForAccount:(NSString *)account
withMinimumConfirmations:(NSNumber *)minconf
          success:(void (^)(NSNumber *))success
          failure:(void (^)(NSError *))failure {
    
    // Be defensive about incoming params.  account could be nil
    if (!account)
        account = @"";
    
    if (!minconf)
        minconf = @0;
    
    [self.bitcoindClient callMethod:@"getbalance" withParams:@[account, minconf] success:^(NSDictionary *jsonData) {
        
        NSNumber *balance = [jsonData valueForKey:RESULT_BITCOIND_JSON_KEY];
        success(balance);
        
        
    } failure:^(NSError *error) {
        NSLog(@"Getbalance Error: %@", error);
        failure(error);
    }];
}

-(void)getBlock:(NSString *)blockHash
        success:(void (^)(BitcoinBlock *))success
        failure:(void (^)(NSError *))failure {
    
    [self.bitcoindClient callMethod:GETBLOCK_BITCOIND_METHOD withParams:@[blockHash] success:^(NSDictionary *jsonData) {
        BitcoinBlock *block = [[BitcoinBlock alloc] initWithDictionary:[jsonData valueForKey:RESULT_BITCOIND_JSON_KEY]];
        success(block);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getBlockCount:(void (^)(NSNumber *))success
             failure:(void (^)(NSError *))failure {
    [self.bitcoindClient callMethod:@"getblockcount" withParams:@[] success:^(NSDictionary *jsonData) {
        success([jsonData valueForKey:RESULT_BITCOIND_JSON_KEY]);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

-(void)getConnectionCount:(void (^)(NSNumber *))success
                  failure:(void (^)(NSError *))failure {
    
    [self.bitcoindClient callMethod:@"getconnectioncount" withParams:@[] success:^(NSDictionary *jsonData) {
        success([jsonData valueForKey:RESULT_BITCOIND_JSON_KEY]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)getDifficulty:(void (^)(NSNumber *))success
             failure:(void (^)(NSError *))failure {
    [self.bitcoindClient callMethod:@"getdifficulty" withParams:@[] success:^(NSDictionary *jsonData) {
        success([jsonData valueForKey:RESULT_BITCOIND_JSON_KEY]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getGenerate:(void (^)(BOOL))success
           failure:(void (^)(NSError *))failure {
    [self.bitcoindClient callMethod:@"getgenerate" withParams:@[] success:^(NSDictionary *jsonData) {
        if ([[jsonData valueForKey:RESULT_BITCOIND_JSON_KEY] boolValue] == YES)
            success(YES);
        else
            success(NO);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getHashesPerSecond:(void (^)(NSNumber *))success
                  failure:(void (^)(NSError *))failure {
    [self.bitcoindClient callMethod:@"gethashespersec" withParams:@[] success:^(NSDictionary *jsonData) {
        success([jsonData valueForKey:RESULT_BITCOIND_JSON_KEY]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getInfo:(void (^)(BitcoindInfo *info))success
       failure:(void (^)(NSError *error))failure {
    
    [self.bitcoindClient callMethod:@"getinfo" withParams:@[] success:^(NSDictionary *jsonData) {
        NSDictionary *infoDict = [[NSDictionary alloc] initWithDictionary:[jsonData objectForKey:RESULT_BITCOIND_JSON_KEY]];
        success([[BitcoindInfo alloc] initWithDictionary:infoDict]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getMiningInfo:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    [self.bitcoindClient callMethod:@"getmininginfo" withParams:@[] success:^(NSDictionary *jsonData) {
        success([jsonData valueForKey:RESULT_BITCOIND_JSON_KEY]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getPeerInfo:(void (^)(NSArray *))success
           failure:(void (^)(NSError *))failure {
    [self.bitcoindClient callMethod:@"getpeerinfo" withParams:@[] success:^(NSDictionary *jsonData) {
        NSArray *peerInfo = [[NSArray alloc] initWithArray:[jsonData valueForKey:RESULT_BITCOIND_JSON_KEY]];
        NSMutableArray *peerList = [[NSMutableArray alloc] init];
        for (NSDictionary *nodeDict in peerInfo) {
            BitcoindNode *node = [[BitcoindNode alloc] initWithDictionary:nodeDict];
            [peerList addObject:node];
        }
        success(peerList);

    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getNewAddress:(NSString *)account
             success:(void (^)(BitcoinAddress *address))success
             failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"getnewaddress" withParams:@[account] success:^(NSDictionary *jsonData) {
        BitcoinAddress *address = [[BitcoinAddress alloc] init];
        address.address = [jsonData valueForKey:RESULT_BITCOIND_JSON_KEY];
        address.isMine = YES;
        address.isValid = YES;
        address.account = account;
        success(address);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

-(void)getRawMemPool:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    [self.bitcoindClient callMethod:@"getrawmempool" withParams:@[] success:^(NSDictionary *jsonData) {
        success([jsonData objectForKey:RESULT_BITCOIND_JSON_KEY]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getRawTransaction:(NSString *)transactionId
                 success:(void (^)(BitcoinRawTransaction *rawTransaction))success
                 failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"getrawtransaction" withParams:@[transactionId, @1] success:^(NSDictionary *jsonData) {
        NSDictionary *rawTransactionDict =[jsonData valueForKey:RESULT_BITCOIND_JSON_KEY];
        BitcoinRawTransaction *rawTransaction = [[BitcoinRawTransaction alloc] initWithDictionary:rawTransactionDict];
        success(rawTransaction);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getReceivedByAccount:(NSString *)account
                    success:(void (^)(NSNumber *))success
                    failure:(void (^)(NSError *))failure {
    
    // Be defensive about incoming params.  account could be nil
    if (!account)
        account = @"";
    
    [self getReceivedByAccount:account withMinimumConfirmations:[NSNumber numberWithInt:1] success:^(NSNumber *balance) {
        success(balance);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


-(void)getReceivedByAccount:(NSString *)account
   withMinimumConfirmations:(NSNumber *)minconf
                    success:(void (^)(NSNumber *))success
                    failure:(void (^)(NSError *))failure {
    
    // Be defensive about incoming params.  account could be nil
    if (!account)
        account = @"";
    
    if (!minconf)
        minconf = @1;
    
    [self.bitcoindClient callMethod:@"getreceivedbyaccount" withParams:@[account, minconf] success:^(NSDictionary *jsonData) {
        
        NSNumber *balance = [jsonData valueForKey:RESULT_BITCOIND_JSON_KEY];
        success(balance);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getReceivedByAddress:(NSString *)address
                    success:(void (^)(NSNumber *))success
                    failure:(void (^)(NSError *))failure {
    [self getReceivedByAddress:address withMinimumConfirmations:@1 success:^(NSNumber *balance) {
        success(balance);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getReceivedByAddress:(NSString *)address
   withMinimumConfirmations:(NSNumber *)minconf
                    success:(void (^)(NSNumber *))success
                    failure:(void (^)(NSError *))failure {
    // Be defensive about incoming params.  address could be nil
    if (!address)
        address = @"";
    
    if (!minconf)
        minconf = @1;

    [self.bitcoindClient callMethod:@"getreceivedbyaddress" withParams:@[address] success:^(NSDictionary *jsonData) {
        success([jsonData valueForKey:RESULT_BITCOIND_JSON_KEY]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getTransaction:(NSString *)transactionId
              success:(void (^)(BitcoinTransaction *transaction))success
              failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"gettransaction" withParams:@[transactionId] success:^(NSDictionary *jsonData) {
         NSDictionary *transactionDict =[jsonData valueForKey:RESULT_BITCOIND_JSON_KEY];
        BitcoinTransaction *transaction = [[BitcoinTransaction alloc] initWithDictionary:transactionDict];
        success(transaction);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


-(void)getNewAddress:(void (^)(BitcoinAddress *address))success
             failure:(void (^)(NSError *error))failure {
    [self getNewAddress:@"" success:^(BitcoinAddress *address) {
        success(address);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


-(void)listAccounts:(void (^)(NSArray *))success
            failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"listaccounts" withParams:@[] success:^(NSDictionary *jsonData) {
        NSDictionary *accountsListDict =[jsonData valueForKey:RESULT_BITCOIND_JSON_KEY];
        NSMutableArray *accountsList = [[NSMutableArray alloc] init];
        for (NSString *key in accountsListDict) {
            //            NSDictionary *accountsDict = @{key:[accountsListDict valueForKey:key]};
            Account *account = [[Account alloc] initWithName:key WithAmount:[accountsListDict valueForKey:key]];
            [accountsList addObject:account];
        }
        success([[NSArray alloc] initWithArray:[NSArray arrayWithArray:accountsList]]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)validateAddress:(NSString *)addressString
               success:(void (^)(BitcoinAddress *address))success
               failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"validateaddress" withParams:@[addressString] success:^(NSDictionary *jsonData) {
        NSDictionary *addressDict =[jsonData valueForKey:RESULT_BITCOIND_JSON_KEY];
        BitcoinAddress *address = [[BitcoinAddress alloc] initWithDictionary:addressDict];
        success(address);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



@end

