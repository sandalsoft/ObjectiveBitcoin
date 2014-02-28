//
//  Account.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/24/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "Account.h"

@implementation Account

-(id)initWithName:(NSString *)name
       WithAmount:(NSNumber *)amount {

    self = [super init];
    if (self) {
        _name = name;
        _balance = amount;
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Name: %@\n Balance: %@\n", self.name, self.balance];
}
@end
