//
//  BitcoindJSONRPCClient.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/22/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import "BitcoindJSONRPCClient.h"

@implementation BitcoindJSONRPCClient


// Singleton implementation using GCD.  Google for details
+(BitcoindJSONRPCClient *)sharedClientWithHost:(NSString *)host
              port:(NSString *)port
          username:(NSString *)username
          password:(NSString *)password {
    
    static BitcoindJSONRPCClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithHost:host port:port username:username password:password];
    });
    return _sharedClient;
}


// init method with params to setup RPC client
- (id)initWithHost:(NSString *)host
              port:(NSString *)port
          username:(NSString *)username
          password:(NSString *)password {
    if (self = [super init]) {
        _hostUrl = [NSString stringWithFormat:@"%@:%@", host, port];
        _username = username;
        _password = password;
        
    }
    return self;
    
}

/**
 *  Proxy method to interface with bitcoind JSON RPC server.  The method and params passed in are used to contruct a NSURLSession and NSMutableURLRequest.  The NSMutableURLRequest sets the proper authentication headers and constructs the HTTP POST body for the bitcoind method passed in
 *
 *  @param methodName Bitcoind method to call
 *  @param params     Paramters to bitcoind method
 *  @param success    Success block returns NSDictionary of JSON containing return data from bitcoind
 *  @param failure    Failure block with NSError
 */
- (void)callMethod:(NSString *)methodName
        withParams:(NSArray *)params
           success:(void (^)(NSDictionary *jsonData))success
           failure:(void (^)(NSError *error))failure {
    
    // Create a defauly NSURLSession config.
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Create the HTTP Basic authentication header.  We concat 'Basic ' + a base64 encoded string of 'username:password'
    // See http://en.wikipedia.org/wiki/Basic_access_authentication#Client_side for more details
    NSString *authString = [NSString stringWithFormat:@"Basic %@", [self encodeUsernamePassword:self.username password:self.password]];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"Authorization":authString};
    
    // Create the NSURLSession using the NSURLSessionConfiguration from above
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];

    
    // Create a mutable URLRequest using the host:port URL passed in
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.hostUrl]];
    
    // Create the body of the HTTP POST.  This contains the bitcoind method to call and any parameters
    NSString *bitcoindPayload = [NSString stringWithFormat:@"{\"jsonrpc\":\"1.0\", \"id\":\"ObjectiveBitcoin - BitcoindJSONRPCCLient\", \"method\": \"%@\", \"params\":%@}",methodName, [self createParamsString:params]];
    
    // Add the HTTP POST body to the NSURLRquest and use the POST method
    request.HTTPBody = [bitcoindPayload dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    // Create the NSURLSessionDataTask to perform the post and handle the response in blocks
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Create NSHTTPURLResponse from the NSURLResponse to read the HTTP status codes so we know how to handle errors
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        
        // Process the response.  Create helpful NSError on known failures
        switch (httpResponse.statusCode) {
                
            // If we get a 200, the POST succeseded.  Parse the response JSON into a NSDictionary and return the success() block
            case 200: {
                NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                success(info);
                break;
            }
                
            //  Authentication Error
            case 401: {
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(@"Operation was unsuccessful.", nil),
                                           NSLocalizedFailureReasonErrorKey:NSLocalizedString(@"Unauthorized.", nil),
                                           NSLocalizedRecoverySuggestionErrorKey:NSLocalizedString(@"Make sure the username and password is valid.", nil),
                                           @"HTTP Response":NSLocalizedString([httpResponse description], nil)};
                NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"ObjectiveBitcoin.BitcoindJSONRPCCLient.%@", methodName] code:httpResponse.statusCode userInfo:userInfo];
                failure(error);
            }
           
                //  Authentication Error
            case 403: {
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(@"Operation was unsuccessful.", nil),
                                           NSLocalizedFailureReasonErrorKey:NSLocalizedString(@"Forbidden Access.", nil),
                                           NSLocalizedRecoverySuggestionErrorKey:NSLocalizedString(@"Make sure the IP address of the client is allowed to conncet to the bitcoind server.  Make sure bitcoind uses -rpcallowip=<ip> or has configration in bitcoin.conf.", nil),
                                           @"HTTP Response":NSLocalizedString([httpResponse description], nil)};
                NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"ObjectiveBitcoin.BitcoindJSONRPCCLient.%@", methodName] code:httpResponse.statusCode userInfo:userInfo];
                failure(error);
            }
                
                
            // Server Error
            case 500: {
                    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(@"Operation was unsuccessful.", nil),
                                               NSLocalizedFailureReasonErrorKey:NSLocalizedString(@"Server Error.", nil),
                                               NSLocalizedRecoverySuggestionErrorKey:NSLocalizedString(@"HTTP 500 Error.  This is usually a problem with the HTTP POST body, or the bitcoind daemon you're hitting has problems.  If you think this is a problem with the HTTP POST, send email to eric@sndl.io with details", nil),
                                               @"HTTP Response":NSLocalizedString([httpResponse description], nil)};
                    
                NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"ObjectiveBitcoin.BitcoindJSONRPCCLient.%@", methodName] code:httpResponse.statusCode userInfo:userInfo];
                    failure(error);
            }
                
            // Unknown or unhandled errors
            default: {
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(@"Operation was unsuccessful.", nil),
                                           NSLocalizedFailureReasonErrorKey:NSLocalizedString(@"Unknown Error.", nil),
                                           NSLocalizedRecoverySuggestionErrorKey:NSLocalizedString(@"Unimplemented Error Handling", nil),
                                           @"HTTP Response":NSLocalizedString([httpResponse description], nil)};
                
                NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"ObjectiveBitcoin.BitcoindJSONRPCCLient.%@", methodName] code:666 userInfo:userInfo];
                failure(error);

            }
                break;
        }

    }];
    
    
    // Kickoff the NSURLSessionDataTask thread
    [postDataTask resume];
}


#pragma mark - Helper methods

/**
 *  Base64 Encodes username and password so it can be passed in the authentication header.  HTTP Basic Auth requires the username and password be concatenated with a : between, then base64 encoded.  This is required for HTTP Basic authentication that bitcoind uses. See http://en.wikipedia.org/wiki/Basic_access_authentication#Client_side for details
 *
 *  @param username bitcoind username
 *  @param password bitcoind password
 *
 *  @return NSString of base64 encoded username and password
 */
- (NSString *)encodeUsernamePassword:(NSString *)username
                            password:(NSString *)password {
    NSString *plainString = [NSString stringWithFormat:@"%@:%@", username, password];
    
    // encode username and password
    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    return [plainData base64EncodedStringWithOptions:0];
}


/**
 *  Creates string from NSArray of parameteres.  Because bitcoind expects method arguments in JSON format in the HTTP POST body, we must construct a JSON string from an array of parameters with all of the appropriate quotes for strings and such.
 *
 *  @param params NSArray of parameters to send to bitcoind method
 *
 *  @return String of JSON encoded params
 */
- (NSString *)createParamsString:(NSArray *)params {
    // If no paras, return empty JSON brackets
    
    if ([params count] == 0 || !params)
        return @"[]";
    
    
    // Alloc and init mutable string of params
    NSMutableString *paramsString = [[NSMutableString alloc] init];
    
    // Beginning of params JSON string.  Params must be in quotes, so we need to escape the quotes in string creation
    [paramsString appendString:@"["];
    
    // If only 1 param, no need to loop, create the string and append the end quote and bracket
    if ([params count] == 1 && [params[0] isKindOfClass:[NSString class]])
        [paramsString appendString:[NSString stringWithFormat:@"\"%@\"]", params[0]]];
    else if ([params count] == 1 && [params[0] isKindOfClass:[NSNumber class]])
       [paramsString appendString:[NSString stringWithFormat:@"%@]", params[0]]]; 
       
    // For more than 1 param, loop through params array and append quoted param and comma: "param",
    else {
        for (int param=0; param < [params count]; param++) {
            if ([params[param] isKindOfClass:[NSNumber class]]) {
                // If the first of multiple params
                if (param == 0)
                    [paramsString appendString:[NSString stringWithFormat:@"%@", params[param]]];
                
                // If the last param, don't append omma but append closing bracket: "param"]
                else
                    [paramsString appendString:[NSString stringWithFormat:@", %@", params[param]]];
            }
            else {
                // If the first of multiple params
                if (param == 0)
                    [paramsString appendString:[NSString stringWithFormat:@"\"%@\"", params[param]]];
                
                // If the last param, don't append omma but append closing bracket: "param"]
                else
                [paramsString appendString:[NSString stringWithFormat:@", \"%@\"", params[param]]];
            }
        }
        [paramsString appendString:@"]"];
    }
    return paramsString;
}


//            // If not the first or last param, append param and comma: "param",
//            else  if (param != ([params count] -1)){
//                [paramsString appendString:[NSString stringWithFormat:@", \"%@\"", params[param]]];
//            }


@end
