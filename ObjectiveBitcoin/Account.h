//
//  Account.h
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/24/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *amount;

-(id)initWithName:(NSString *)name
       WithAmount:(NSNumber *)amount;

@end
