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
        _address = stringAddress;
    }
    return self;
    
}


- (id)initWithDictionary:(NSDictionary *)addressDict {
    if ((self = [super init])) {
        _address = [addressDict valueForKey:@"address"];
        _publicKey = [addressDict valueForKey:@"pubkey"];
        _account = [addressDict valueForKey:@"account"];

        if ([[addressDict valueForKey:@"isvalid"] boolValue])
            _isValid = YES;
        else
            _isValid = NO;
        
        if ([[addressDict valueForKey:@"ismine"] boolValue])
            _isMine = YES;
        else
            _isMine = NO;
        
        if ([[addressDict valueForKey:@"isscript"] boolValue])
            _isScript = YES;
        else
            _isScript = NO;
        
        if ([[addressDict valueForKey:@"iscompressed"] boolValue])
            _isCompressed = YES;
        else
            _isCompressed = NO;
        
    }
    return self;
}


-(NSString *)description {
    return [NSString stringWithFormat:@"IsValid: %hhu\n Address: %@\n IsMine: %hhu\n IsScript: %hhu\n Public Key: %@\n IsCompressed: %hhu\n Account: %@\n", self.isValid, self.address, self.isMine, self.isScript, self.publicKey, self.isCompressed, self.account];
}

@end
