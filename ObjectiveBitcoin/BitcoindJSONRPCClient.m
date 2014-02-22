//
//  BitcoindJSONRPCClient.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/22/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "BitcoindJSONRPCClient.h"

@implementation BitcoindJSONRPCClient

+ (void)callMethod:(NSString *)methodName
               url:(NSString *)hostURL
        withParams:(NSArray *)params
          username:(NSString *)username
          password:(NSString *)password
        useTestnet:(Boolean)isTestnet
           success:(void (^)(NSDictionary *jsonData))success
           failure:(void (^)(NSURLResponse *error))failure {
    
    
    NSLog(@"paramsString: %@", [self createParamsString:params]);
    NSString *bitcoindPayload = [NSString stringWithFormat:@"{\"jsonrpc\":\"1.0\", \"id\":\"objective-c test\", \"method\": \"%@\", \"params\":%@}",methodName, [self createParamsString:params]];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSString *tits = [NSString stringWithFormat:@"Basic %@", [self encodeUsernamePassword:username password:password]];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"Authorization":tits}; //,@"Content-Length":payloadLength};
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:@"http://dev.sndl.io:18332/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [bitcoindPayload dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    //    NSLog(@"request: %@", [request description]);
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        if (httpResp.statusCode == 200) {
            NSError *jsonError;
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            success(info);
//            NSLog(@"info: %@", [info description]);
        }
        else {
            failure(response);
        }
    }];
    [postDataTask resume];
}

+ (NSString *)encodeUsernamePassword:(NSString *)username
                            password:(NSString *)password {
    NSString *plainString = [NSString stringWithFormat:@"%@:%@", username, password];
    
    // encode username and password
    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    return [plainData base64EncodedStringWithOptions:0];
}


+ (NSString *)createParamsString:(NSArray *)params {
    // If no paras, return empty JSON brackets
    if ([params count] == 0)
        return @"[]";
    
    // Alloc and init mutable string of params
    NSMutableString *paramsString = [[NSMutableString alloc] init];
    
    // Beginning of params JSON string.  Params must be in quotes, so we need to escape the quotes in string creation
    [paramsString appendString:@"[\""];
    
    // If only 1 param, no need to loop, create the string and append the end quote and bracket
    if ([params count] == 1)
        [paramsString appendString:[NSString stringWithFormat:@"%@\"]", params[0]]];
    
    // For more than 1 param, loop through params array and append quoted param and comma: "param",
    else {
        
        for (int param=0; param < [params count]; param++) {
            
            // If not the last param, append param and comma: "param",
            if (param != ([params count] -1))
                [paramsString appendString:[NSString stringWithFormat:@"\"%@\"]", params[param]]];
            
            // If the last param, don't append omma but append closing bracket: "param"]
            else
                [paramsString appendString:[NSString stringWithFormat:@"\"%@\", ", params[param]]];
        }
    }
    return paramsString;
}



@end
