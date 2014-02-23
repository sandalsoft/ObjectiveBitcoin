//
//  BitcoinAddress.h
//  Pods
//
//  Created by Eric Nelson on 2/23/14.
//
//

#import <Foundation/Foundation.h>

@interface BitcoinAddress : NSObject

@property (strong, nonatomic) NSString *addressString;

-(id)initWithString:(NSString *)stringAddress;
-(NSString *)stringValue;
-(NSString *)description;

@end


