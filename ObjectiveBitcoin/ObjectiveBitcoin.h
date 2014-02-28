//
//  ObjectiveBitcoin.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "BitcoinTransaction.h"
#import "BitcoinRawTransaction.h"
#import "BitcoinBlock.h"
#import "BitcoindInfo.h"
#import "BitcoindJSONRPCClient.h"
#import "BitcoinAddress.h"
#import "Account.h"



@interface ObjectiveBitcoin : NSObject

@property BitcoindJSONRPCClient *bitcoindClient;


/**
 *  Instantiates BitcoindJSONRPCClient singleton.  Accepts parameters needed to setup the shared BitcoindJSONRPCClient client that can be resused.
 *
 *  @param host     Host running bitcoind
 *  @param port     The port bitcoind is listening on.  8332 for production, 18332 for testnet
 *  @param username The username to bitcoind is configured to allow access
 *  @param password The password for the username
 *
 *  @return a BitcoindJSONRPCClient singleton
 */
-(id)initWithHost:(NSString *)host
         port:(NSString *)port
     username:(NSString *)username
     password:(NSString *)password;

#pragma mark - bitcoind methods

/**
 *  Returns info about running bitcoind instance.  Bitcoind method: getinfo
 *
 *
 *  @param success Success block with BitcoindInfo object
 *  @param failure Failure block with NSError
 */
-(void)getInfo:(void (^)(BitcoindInfo *info))success
       failure:(void (^)(NSError *error))failure;


/**
 *  Returns current bitcoin address for receiving payments to this account.  Bitcoind method: getaccountaddress
 *
 *  @param account The account string to get address for
 *  @param success Success block with BitcoinAddress object
 *  @param failure Failure block with NSError
 */
-(void)getAccountAddress:(NSString *)account
              success:(void (^)(BitcoinAddress *address))success
              failure:(void (^)(NSError *error))failure;


-(void)getBalanceForAccount:(NSString *)account
          success:(void (^)(NSNumber *balance))success
          failure:(void (^)(NSError *error))failure;

-(void)getBalanceForAccount:(NSString *)account
withMinimumConfirmations:(NSNumber *)minconf
          success:(void (^)(NSNumber *balance))success
          failure:(void (^)(NSError *error))failure;


/**
 *  Returns the total amount received by addresses in the specified account in transactions with at least 1 confirmation. If account not provided return will include all transactions to all accounts.
 *
 *  @param account Account name
 *  @param success Success block with the amount
 *  @param failure Failure block with NSError
 */
-(void)getReceivedByAccount:(NSString *)account
                    success:(void (^)(NSNumber *amount))success
                    failure:(void (^)(NSError *error))failure;

/**
 *  eturns the total amount received by addresses in the specified account in transactions with at least x confirmations. If account not provided return will include all transactions to all accounts.
 *
 *  @param account Account name
 *  @param minconf Number of minimum confirmations
 *  @param success Success block with the amount
 *  @param failure Failure block with NSError
 */
-(void)getReceivedByAccount:(NSString *)account
   withMinimumConfirmations:(NSNumber *)minconf
                    success:(void (^)(NSNumber *amount))success
                    failure:(void (^)(NSError *error))failure;


/**
 *  Determines if an address is valid and if it is owned by this wallet.  Returns details of the address
 *
 *  @param addressString Bitcoin address string
 *  @param success       Success block with details of the address
 *  @param failure       Failure block with NSError
 */
-(void)validateAddress:(NSString *)addressString
               success:(void (^)(BitcoinAddress *address))success
               failure:(void (^)(NSError *error))failure;

-(void)listAccounts:(void (^)(NSArray *accounts))success
       failure:(void (^)(NSError *error))failure;

-(void)getTransaction:(NSString *)transactionId
              success:(void (^)(BitcoinTransaction *transaction))success
              failure:(void (^)(NSError *error))failure;

-(void)getRawTransaction:(NSString *)transactionId
                 success:(void (^)(BitcoinRawTransaction *rawTransaction))success
                 failure:(void (^)(NSError *error))failure;

-(void)getNewAddress:(void (^)(BitcoinAddress *address))success
             failure:(void (^)(NSError *error))failure;

-(void)getNewAddress:(NSString *)account
             success:(void (^)(BitcoinAddress *address))success
             failure:(void (^)(NSError *error))failure;


////////////////////////////////////////////////////



-(void)getBalanceForAddress:(NSString *)address
   withMinimumConfirmations:(NSNumber *)minconf
                    success:(void (^)(NSNumber *balance))success
                    failure:(void (^)(NSError *error))failure;

-(void)getReceivedByAddress:(NSString *)address
                    success:(void (^)(NSNumber *balance))success
                    failure:(void (^)(NSError *error))failure;

-(void)getReceivedByAddress:(NSString *)address
   withMinimumConfirmations:(NSNumber *)minconf
                    success:(void (^)(NSNumber *balance))success
                    failure:(void (^)(NSError *error))failure;

-(void)getPeerInfo:(void (^)(NSArray *peerList))success
                  failure:(void (^)(NSError *error))failure;

-(void)getAddedNodeInfo:(Boolean)useDNS
                    success:(void (^)(NSString *blockHash))success
                    failure:(void (^)(NSError *error))failure;

-(void)getAddedNodeInfo:(Boolean)useDNS
                   node:(NSString *)nodeString
                success:(void (^)(NSString *blockHash))success
                failure:(void (^)(NSError *error))failure;

-(void)getBlock:(NSString *)blockHash
                    success:(void (^)(BitcoinBlock *block))success
                    failure:(void (^)(NSError *error))failure;

-(void)getBlockHashForBlock:(NSNumber *)blockNumber
            success:(void (^)(NSString *blockHash))success
            failure:(void (^)(NSError *error))failure;

-(void)getBlockCount:(void (^)(NSNumber *blocks))success
                  failure:(void (^)(NSError *error))failure;

-(void)getConnectionCount:(void (^)(NSNumber *connections))success
             failure:(void (^)(NSError *error))failure;

-(void)getDifficulty:(void (^)(NSNumber *difficulty))success
               failure:(void (^)(NSError *error))failure;

-(void)getHashesPerSec:(void (^)(NSNumber *hashesPerSecond))success
             failure:(void (^)(NSError *error))failure;

-(void)getRawMemPool:(void (^)(NSArray *poolList))success
             failure:(void (^)(NSError *error))failure;

-(void)getGenerate:(void (^)(Boolean *isGeneratingHashes))success
             failure:(void (^)(NSError *error))failure;

-(void)getMiningInfo:(void (^)(NSDictionary *miningInfoDict))success
       failure:(void (^)(NSError *error))failure;





@end
