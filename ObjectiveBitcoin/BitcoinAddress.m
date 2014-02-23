//
//  BitcoinAddress.m
//  Pods
//
//  Created by Eric Nelson on 2/23/14.
//
//

#import "BitcoinAddress.h"

@implementation BitcoinAddress

-(id)initWithString:(NSString *)stringAddress {
    
    self = [super init];
    if (self) {
        _addressString = stringAddress;
    }
    return self;
    
}

-(NSString *)stringValue {
    return self.addressString;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Address: %@", self.addressString];
}

@end
