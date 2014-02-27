//
//  ObjectiveBitcoinTests.m
//  ObjectiveBitcoinTests
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSONHelper.h"

#import "ObjectiveBitcoin.h"

@interface ObjectiveBitcoinTests : XCTestCase

@end

@implementation ObjectiveBitcoinTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetInfo
{
    
    NSData *data = [[NSData alloc] initWithData:[JSONHelper dataFromJSONFileNamed:@"getinfo"]];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *infoDict = [[NSDictionary alloc] initWithDictionary:[jsonData objectForKey:@"result"]];
    NSLog(@"infoDict: %@", infoDict);
    XCTAssertNil(nil, @"hi");
}

@end
