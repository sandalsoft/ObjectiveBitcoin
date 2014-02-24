//
//  BitcoindNode.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/24/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BitcoindNode : NSObject

//"addr" : "144.76.133.145:18333",
//"services" : "00000001",
//"lastsend" : 1393265666,
//"lastrecv" : 1393265666,
//"bytessent" : 7571130,
//"bytesrecv" : 3128851,
//"conntime" : 1393017799,
//"version" : 70001,
//"subver" : "/Satoshi:0.8.99/",
//"inbound" : false,
//"startingheight" : 190784,
//"banscore" : 0

@property (strong, nonatomic) NSString *addressAndPort;
@property (strong, nonatomic) NSString *service;
@property (strong, nonatomic) NSNumber *lastSend;
@property (strong, nonatomic) NSNumber *lastReceive;

@end
