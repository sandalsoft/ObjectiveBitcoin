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

- (void)testEncodeUsernamePassword {
    XCTAssertTrue([[self.client encodeUsernamePassword:@"u" password:@"p"] isEqualToString:@"dTpw"],@"Base64 Encoded \"u:p\" should equal \"dTpw\"");
}


-(void)testCreateParamsString {
    
    
}
@end
