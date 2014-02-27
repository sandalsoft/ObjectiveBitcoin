//
//  ObjectiveBitcoinTests.m
//  ObjectiveBitcoinTests
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSONHelper.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "ObjectiveBitcoin.h"

#define TestNeedsToWaitForBlock() __block BOOL blockFinished = NO
#define BlockFinished() blockFinished = YES
#define WaitForBlock() while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !blockFinished)

@interface ObjectiveBitcoinTests : XCTestCase

@property (strong, nonatomic) ObjectiveBitcoin *client;

@end

@implementation ObjectiveBitcoinTests

- (void)setUp
{
    [super setUp];


    NSString *host = @"http://dev.sndl.io";
    NSString *port = @"18332";
    NSString *username = @"u";
    NSString *password = @"p";
    
    self.client = [[ObjectiveBitcoin alloc] initWithHost:host port:port username:username password:password];

//    __block NSData *stubData = [[NSData alloc] initWithData:[JSONHelper dataFromJSONFileNamed:@"getinfo"]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES; // Stub ALL requests without any condition
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub all those requests with "Hello World!" string
        NSData *stubData = [[NSData alloc] initWithData:[@"{     \"result\": {         \"version\": 80600,         \"protocolversion\": 70001,         \"walletversion\": 60000,         \"balance\": 3.09890000,         \"blocks\": 666666,         \"timeoffset\": -1,         \"connections\": 12,         \"proxy\": \"\",         \"difficulty\": 149.44336068,         \"testnet\": true,         \"keypoololdest\": 1391109962,         \"keypoolsize\": 101,         \"paytxfee\": 0.00000000,         \"errors\": \"\"     },     \"error\": null,     \"id\": \"curltest\" } " dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        return [OHHTTPStubsResponse responseWithData:stubData statusCode:200 headers:nil];
    }];
    
    
    
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//        return YES;
//    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
//        // Stub it with our "wsresponse.json" stub file
//        NSData *stubData = [[NSData alloc] initWithData:[JSONHelper dataFromJSONFileNamed:@"getinfo"]];
//
//        return [OHHTTPStubsResponse responseWithData:stubData statusCode:200 headers:@{@"Content-Type":@"application/json"}];
//    }];
    

    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetInfo
{

    TestNeedsToWaitForBlock();
    
    [self.client getInfo:^(BitcoindInfo *info) {
        XCTAssertTrue([info.blocks isEqualToNumber:@666666], @"getInfo.Blocks should be 666666");
        BlockFinished();
    } failure:^(NSError *error) {
        NSLog(@"TEST ERROR: %@", [error description]);
        BlockFinished();
    }];

    WaitForBlock();
}

@end
