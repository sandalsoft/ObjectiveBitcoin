//
//  ObjectiveBitcoinTests.m
//  ObjectiveBitcoinTests
//
//  Created by Eric Nelson on 2/1/14.
//  Copyright (c) 2014 Sandalsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "ObjectiveBitcoin.h"

#define TestNeedsToWaitForBlock() __block BOOL blockFinished = NO
#define BlockFinished() blockFinished = YES
#define WaitForBlock() while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !blockFinished)

@interface ObjectiveBitcoinTests : XCTestCase

@property (strong, nonatomic) NSString *OHTTPStubHostString;

@property (strong, nonatomic) NSString *host;
@property (strong, nonatomic) NSString *port;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *block;
@property (strong, nonatomic) NSString *accountName;
@property (strong, nonatomic) NSString *bitcoinAddress;
@property (weak, nonatomic) NSString *localTransactionId;
@property (weak, nonatomic) NSString *foreignTransactionId;

@property (strong, nonatomic) ObjectiveBitcoin *client;

@end

@implementation ObjectiveBitcoinTests

- (void)setUp {
    [super setUp];

    // Setup properties of bitcoind RPC Client and params to send methods for testing.  These params are valid -testnet values.
    self.OHTTPStubHostString = @"dev.sndl.io";
    self.host = @"http://dev.sndl.io";
    self.port = @"18332";
    self.username = @"u";
    self.password = @"p";
    self.block = @"00000000f275c4a72eb44e2385d4ac0acb5760b111fc335c5c400945cbc3bba5";
    self.accountName = @"test";
    self.bitcoinAddress = @"moFizF4tnNgaGRtwfV3uxvB4VfWzsv5rvU";
    self.localTransactionId = @"d055ca8afe3ce9e692f7df70210b52755e51d067de0e7085da73b9d28ba14876";
    self.foreignTransactionId =  @"5a93b1f50f83b2cc5214b76ad87230f88908e128bda33cb823961bc1d98703f1";
    
    // Instantiate the client singleton
    self.client = [[ObjectiveBitcoin alloc] initWithHost:self.host port:self.port username:self.username password:self.password];
    
}

- (void)tearDown {
    [super tearDown];
    
    // Remove stubs after each test method.  Failure to do this can cause stubs to hang around and get mixed with other tests yielding unpredictable results
    [OHHTTPStubs removeAllStubs];
    
}


- (void)testGetBalance {
    // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client getBalanceForAccount:@"test" success:^(NSNumber *balance) {
        XCTAssertTrue([balance isEqualToNumber:@3.09890000], @"Balance should equal 3.09890000");
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();
}

- (void)testGetBlock {
        // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client getBlock:@"00000000f275c4a72eb44e2385d4ac0acb5760b111fc335c5c400945cbc3bba5" success:^(BitcoinBlock *block) {
        XCTAssertTrue([block.height isEqualToNumber:@193346], @"%@ should equal to 193346", block.height);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();
}

- (void)testGetDifficulty {
    // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();

    [self.client getDifficulty:^(NSNumber *difficulty) {
        XCTAssertTrue([difficulty isEqualToNumber:@12345], @"%@ should be equal to 12345", difficulty);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();
    
}
- (void)testGetHashesPerSecond {
    // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client getHashesPerSecond:^(NSNumber *hashesPerSecond) {
        XCTAssertTrue([hashesPerSecond isEqualToNumber:@69], @"%@ should be equal to 69", hashesPerSecond);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();
}

- (void)testGetInfo {
    // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client getInfo:^(BitcoindInfo *info) {
        XCTAssertTrue([info.blocks isEqualToNumber:@666666], @"%@ should be equal to 666666", info.blocks );
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();
}

-(void)testGetPeerInfo {
    // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();

    [self.client getPeerInfo:^(NSArray *peerList) {
        BitcoindNode *node = [[BitcoindNode alloc] init];
        node = peerList[1];
        XCTAssertTrue([node.bytesReceived isEqualToNumber:@75199], @"%@ should be equal to 75199", node.bytesReceived);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();
}

- (void)testGetRawTransaction {
    // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client getRawTransaction:self.foreignTransactionId success:^(BitcoinRawTransaction *rawTransaction) {
//        NSLog(@"vout: %@", [rawTransaction.vOut description]);
        XCTAssertNotNil(rawTransaction.vOut, @"%@ should not be nil", rawTransaction.vOut);
        XCTAssertTrue([rawTransaction.confirmations isEqualToNumber:@11720], @"%@ should equal 11720", rawTransaction.confirmations);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];

    WaitForBlock();
}

- (void)testGetReceivedByAddress {
    // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();

    [self.client getReceivedByAddress:self.bitcoinAddress success:^(NSNumber *balance) {
        XCTAssertTrue([balance isEqualToNumber:@6.90000000], @"%@ should be equal to 6.90000000", balance);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();
    
}
- (void)testGetTransaction {
    // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client getTransaction:self.localTransactionId success:^(BitcoinTransaction *transaction) {
        
        XCTAssertTrue([transaction.confirmations isEqualToNumber:@11534], @"%@ should equal 1392513742", transaction.confirmations);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    
    WaitForBlock();
}

- (void)testGetReceivedByAccount {
        // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client getReceivedByAccount:@"test" success:^(NSNumber *balance) {
        XCTAssertTrue([balance isEqualToNumber:@1.60000000], @"%@ should be 1.60000000", balance);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    WaitForBlock();
}

- (void)testListAccounts {
        // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client listAccounts:^(NSArray *accounts) {
        Account *account = [[Account alloc] init];
        account = accounts[1];
        XCTAssertTrue([account.name isEqualToString:@"test"], @"%@ is equal to test", account.name);
        XCTAssertTrue([account.balance isEqualToNumber:@1.6000000], @"%@ is equal to 1.6000000", account.balance);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();
}

- (void)testValidateAddress {
        // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client validateAddress:self.bitcoinAddress success:^(BitcoinAddress *address) {
        XCTAssertTrue([address.publicKey isEqualToString:@"03bcc6688da1e9921e4291826fd58f1748c1992ae2dbf55cd57aa2295ee5aede27"], @"%@ should be 03bcc6688da1e9921e4291826fd58f1748c1992ae2dbf55cd57aa2295ee5aede27", address.publicKey);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();
}

- (void)testGetBlockCount {
    // Extracts the stub data filename from the test method name.  It removes the first 4 characters, then lowercases it
    NSString *stubDataFileName = [NSString stringWithFormat:@"%@.json", [[NSStringFromSelector(_cmd) substringFromIndex:4] lowercaseString]];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.OHTTPStubHostString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(stubDataFileName, nil) statusCode:200 headers:nil];
    }].name = [NSString stringWithFormat:@"Stub for %@", NSStringFromSelector(_cmd)];
    
    TestNeedsToWaitForBlock();
    
    [self.client getBlockCount:^(NSNumber *blockCount) {
        XCTAssertTrue([blockCount isEqualToNumber:@194434], @"%@ should equal 194434", blockCount);
        BlockFinished();
    } failure:^(NSError *error) {
        XCTFail(@"Failure in %@", NSStringFromSelector(_cmd));
        BlockFinished();
    }];
    
    WaitForBlock();

}

@end
