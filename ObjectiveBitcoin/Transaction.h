//
//  Transaction.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/15/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject


@property (strong, nonatomic) NSNumber *Amount;
@property (strong, nonatomic) NSNumber *Confirmations;
@property (strong, nonatomic) NSString *BlockHash;
@property (strong, nonatomic) NSNumber *BlockIndex;
@property (strong, nonatomic) NSDate *BlockTime;
@property (strong, nonatomic) NSString *TxId;
@property (strong, nonatomic) NSDate *Time;
@property (strong, nonatomic) NSDate *TimeReceived;
@property (strong, nonatomic) NSArray *Details;




@end
