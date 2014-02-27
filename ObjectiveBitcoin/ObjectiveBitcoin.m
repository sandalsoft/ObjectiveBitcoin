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
-(void)getInfo:(void (^)(BitcoindInfo *info))success
       failure:(void (^)(NSError *error))failure {
    
    [self.bitcoindClient callMethod:@"getinfo" withParams:@[] success:^(NSDictionary *jsonData) {
        NSDictionary *infoDict = [[NSDictionary alloc] initWithDictionary:[jsonData objectForKey:@"result"]];
        success([[BitcoindInfo alloc] initWithDictionary:infoDict]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)getAccountAddress:(NSString *)account
                 success:(void (^)(BitcoinAddress *address))success
                 failure:(void (^)(NSError *error))failure {
    
    [self.bitcoindClient callMethod:@"getaccountaddress" withParams:@[account] success:^(NSDictionary *jsonData) {
        NSString *addressString = [jsonData valueForKey:@"result"];
        BitcoinAddress *address = [[BitcoinAddress alloc] initWithString:addressString];
        success(address);
    } failure:^(NSError *error) {
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
        minconf = 0;
    
    [self.bitcoindClient callMethod:@"getbalance" withParams:@[account, minconf] success:^(NSDictionary *jsonData) {
        
        NSNumber *balance = [jsonData valueForKey:@"result"];
        success(balance);
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}



-(void)validateAddress:(NSString *)addressString
               success:(void (^)(BitcoinAddress *address))success
               failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"validateaddress" withParams:@[addressString] success:^(NSDictionary *jsonData) {
        NSDictionary *addressDict =[jsonData valueForKey:@"result"];
        BitcoinAddress *address = [[BitcoinAddress alloc] initWithDictionary:addressDict];
        success(address);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)listAccounts:(void (^)(NSArray *))success
            failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"listaccounts" withParams:@[] success:^(NSDictionary *jsonData) {
        NSDictionary *accountsListDict =[jsonData valueForKey:@"result"];
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

-(void)getTransaction:(NSString *)transactionId
              success:(void (^)(BitcoinTransaction *transaction))success
              failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"gettransaction" withParams:@[transactionId] success:^(NSDictionary *jsonData) {
         NSDictionary *transactionDict =[jsonData valueForKey:@"result"];
        BitcoinTransaction *transaction = [[BitcoinTransaction alloc] initWithDictionary:transactionDict];
        success(transaction);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

-(void)getRawTransaction:(NSString *)transactionId
                 success:(void (^)(BitcoinRawTransaction *rawTransaction))success
                 failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"getrawtransaction" withParams:@[transactionId] success:^(NSDictionary *jsonData) {
        NSDictionary *rawTransactionDict =[jsonData valueForKey:@"result"];
        BitcoinRawTransaction *rawTransaction = [[BitcoinRawTransaction alloc] initWithDictionary:rawTransactionDict];
        success(rawTransaction);
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

-(void)getNewAddress:(NSString *)account
             success:(void (^)(BitcoinAddress *address))success
             failure:(void (^)(NSError *error))failure {
    [self.bitcoindClient callMethod:@"getnewaddress" withParams:@[account] success:^(NSDictionary *jsonData) {
        BitcoinAddress *address = [[BitcoinAddress alloc] init];
        address.address = [jsonData valueForKey:@"result"];
        address.isMine = YES;
        address.isValid = YES;
        address.account = account;
        success(address);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end

