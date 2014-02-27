//
//  JSONHelper.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/25/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "JSONHelper.h"

@implementation JSONHelper

+ (id)dataFromJSONFileNamed:(NSString *)fileName
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    NSLog(@"BUNDLE: %@"), [bundle;
    NSString *resource = [bundle pathForResource:fileName ofType:@"json"];
    
    if (NSClassFromString(@"NSJSONSerialization")) {
        NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:resource];
        [inputStream open];
        
        return [NSJSONSerialization JSONObjectWithStream:inputStream options:0 error:nil];
    } else {
        NSData *jsonData = [NSData dataWithContentsOfFile:resource];
        return jsonData;
    }
}

@end
