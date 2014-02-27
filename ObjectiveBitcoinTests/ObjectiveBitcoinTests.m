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
//        NSLog(@"request: %@",  request.HTTPBody);
           return [request.URL.host isEqualToString:@"dev.sndl.io"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"getinfo.json", nil) statusCode:200 headers:nil];
    }];
    
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
        XCTAssertNil(@"bewbz", @"In failure block :(");
        BlockFinished();
    }];

    WaitForBlock();
}

@end
