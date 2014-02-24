//
//  Account.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/24/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "Account.h"

@implementation Account


//@property (strong, nonatomic) NSString *name;
//@property (strong, nonatomic) NSNumber *amount;

-(id)initWithName:(NSString *)name
       WithAmount:(NSNumber *)amount {

    self = [super init];
    if (self) {
        _name = name;
        _amount = amount;
    }
    return self;
}


@end
