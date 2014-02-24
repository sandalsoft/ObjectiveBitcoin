//
//  BitcoindNode.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/24/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "BitcoindNode.h"

@implementation BitcoindNode

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

-(id)initWithDictionary:(NSDictionary *)nodeDict {
    if ((self = [super init])) {
        _addressAndPort = [nodeDict valueForKey:@"addr"];
        _services = [nodeDict valueForKey:@"services"];
        _lastSend = [NSDate dateWithTimeIntervalSince1970:[[nodeDict valueForKey:@"lastsend"] doubleValue]];
        _lastReceive = [NSDate dateWithTimeIntervalSince1970:[[nodeDict valueForKey:@"lastrecv"] doubleValue]];
        _bytesSent = [nodeDict valueForKey:@"bytessent"];
        _bytesReceived = [nodeDict valueForKey:@"bytesrecv"];
        _ConnectionTime = [NSDate dateWithTimeIntervalSince1970:[[nodeDict valueForKey:@"conntime"] doubleValue]];
        _version = [nodeDict valueForKey:@"version"];
        _subVersion = [nodeDict valueForKey:@"subver"];
        _startingHeight = [nodeDict valueForKey:@"startingheight"];
        _banScore = [nodeDict valueForKey:@"banscore"];
        
        if ([[nodeDict valueForKey:@"inbound"] boolValue])
            _isInbound = YES;
        else
            _isInbound = NO;
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Address: %@\n Services: %@\n Last Send Date: %@\n Last Receive Date: %@\n Bytes Sent: %@\n Bytes Received: %@\n Connection Time: %@\n Version: %@\n Sub Version: %@\n Inbound: %hhu\n Starting Block Height: %@\n Ban Score: %@", self.addressAndPort, self.services, self.lastSend, self.lastReceive, self.bytesSent, self.bytesReceived, self.ConnectionTime, self.version, self.subVersion, self.isInbound, self.startingHeight, self.banScore];
}

@end
