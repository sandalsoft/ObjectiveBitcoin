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
@property (strong, nonatomic) NSString *services;
@property (strong, nonatomic) NSDate *lastSend;
@property (strong, nonatomic) NSDate *lastReceive;
@property (strong, nonatomic) NSNumber *bytesSent;
@property (strong, nonatomic) NSNumber *bytesReceived;
@property (strong, nonatomic) NSDate *ConnectionTime;
@property (strong, nonatomic) NSNumber *version;
@property (strong, nonatomic) NSString *subVersion;
@property (assign, nonatomic) Boolean isInbound;
@property (strong, nonatomic) NSNumber *startingHeight;
@property (strong, nonatomic) NSNumber *banScore;


-(id)initWithDictionary:(NSDictionary *)nodeDict;

-(NSString *)description;

@end
