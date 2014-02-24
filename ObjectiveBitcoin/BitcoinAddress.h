//
//  BitcoinAddress.h
//  Pods
//
//  Created by Eric Nelson on 2/23/14.
//
//

#import <Foundation/Foundation.h>

@interface BitcoinAddress : NSObject


@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) Boolean isMine;
@property (strong, nonatomic) NSString *publicKey;
@property (strong, nonatomic) NSString *account;
@property (assign, nonatomic) Boolean isScript;
@property (assign, nonatomic) Boolean isValid;
@property (assign, nonatomic) Boolean isCompressed;

-(id)initWithString:(NSString *)stringAddress;
-(id)initWithDictionary:(NSDictionary *)addressDict;

-(NSString *)description;

@end


