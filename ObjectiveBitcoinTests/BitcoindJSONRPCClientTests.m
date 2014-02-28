//
//  BitcoindJSONRPCClientTests.m
//  ObjectiveBitcoin
//
//  Created by Eric Nelson on 2/25/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BitcoindJSONRPCClient.h"

@interface BitcoindJSONRPCClientTests : XCTestCase

@property (strong, nonatomic) BitcoindJSONRPCClient *client;

@end

@implementation BitcoindJSONRPCClientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _client = [[BitcoindJSONRPCClient alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
 
 
 
 
            TODO:  Add tests that exercise callMethod and test for error codes
 
                Create tests with failing HTTP status codes to ensure method fails properly
 
                Create test that checks bitcoind error response JSON for null
 
 
 */

- (void)testEncodeUsernamePassword {
    XCTAssertTrue([[self.client encodeUsernamePassword:@"u" password:@"p"] isEqualToString:@"dTpw"],@"Base64 Encoded \"u:p\" should equal \"dTpw\"");
}


-(void)testCreateParamsString {

    // Test multiple params passed into createParamString creates proper HTTP body string for JSON RPC call
    NSString *multiParams = [NSString stringWithString:[self.client createParamsString:@[@"param1", @"param 2", @3]]];
    XCTAssertTrue([multiParams isEqualToString:@"[\"param1\", \"param 2\", 3]"], @"%@ should be equal to \"[\"param1\", \"param 2\", 3]", multiParams);
    
    // Test a single NSSTring param passed into createParamString creates proper HTTP body string for JSON RPC call
    NSString *singleParamString =[NSString stringWithString:[self.client createParamsString:@[@"param1"]]];
    XCTAssertTrue([singleParamString isEqualToString:@"[\"param1\"]"], @"%@ should be equal to \"[\"param1\"]", singleParamString);
    
    // Test a single NSNumber param passed into createParamString creates proper HTTP body string for JSON RPC call
    NSString *singleParamNumber =[self.client createParamsString:@[@69]] ;
    XCTAssertTrue([singleParamNumber  isEqualToString:@"[69]"], @"%@ should be equal to [69]", singleParamNumber);
    
}

@end
