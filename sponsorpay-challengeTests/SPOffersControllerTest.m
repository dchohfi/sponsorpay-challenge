//
//  SPOffersControllerTest.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPOffersControllerTest.h"
#import "SPOffersController.h"
#import "OHHTTPStubs.h"
#import "OCMock.h"
#import "SPHashCalculator.h"

@interface SPOffersControllerTest()

@property (nonatomic, assign) dispatch_semaphore_t semaphore;


@end

@implementation SPOffersControllerTest

- (BOOL) validateResponseForBody: (NSString *) responseBody forApiKey: (NSString *) apiKey andDesiredHash: (NSString *) hash {
    return YES;
}
- (void)runTestWithBlock:(void (^)(void))block {
    self.semaphore = dispatch_semaphore_create(0);
    
    block();
    
    while (dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    
    dispatch_release(self.semaphore);
}

- (void)blockTestCompletedWithBlock:(void (^)(void))block {
    dispatch_semaphore_signal(self.semaphore);
    
    if (block) {
        block();
    }
}

- (void) testShouldReturnEmptyOffersForNoContentMessage {
    [self runTestWithBlock:^{
        id hashMock = [OCMockObject mockForClass:[SPHashCalculator class]];
        [[[[hashMock stub] classMethod] andReturnValue:@YES] validateResponseForBody:[OCMArg any]
                                                                           forApiKey:[OCMArg any]
                                                                      andDesiredHash:[OCMArg any]];
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return YES;
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            return [OHHTTPStubsResponse responseWithFile:@"no_offers.json"
                                             contentType:@"text/json"
                                            responseTime:1.0];
        }];
        
        [SPOffersController getOffers:nil
                         successBlock:^(NSArray *offers) {
                             [self blockTestCompletedWithBlock:^{
                                 STAssertEquals(0u, offers.count, @"Should return an array with zero offers when the response return a no content code");
                             }];
                         } andFailBlock:^(NSError *error) {
                             NSLog(@"ERROR %@", [error description]);
                             [self blockTestCompletedWithBlock:^{
                                 STFail(@"Should not come to the fail block");
                             }];
                         }];
    }];

}
- (void) testShouldCallErrorBlockIfTheHashFailsToValidateTheResponse {
    [self runTestWithBlock:^{
        id hashMock = [OCMockObject mockForClass:[SPHashCalculator class]];
        [[[[hashMock stub] classMethod] andReturnValue:@NO] validateResponseForBody:[OCMArg any]
                                                                          forApiKey:[OCMArg any]
                                                                     andDesiredHash:[OCMArg any]];
        
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return YES;
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            return [OHHTTPStubsResponse responseWithFile:@"no_offers.json"
                                             contentType:@"text/json"
                                            responseTime:1.0];
        }];
        
        [SPOffersController getOffers:nil
                         successBlock:^(NSArray *offers) {
                             [self blockTestCompletedWithBlock:^{
                                 STFail(@"Should not come to the success block for an invalid parsed response");
                             }];
                         } andFailBlock:^(NSError *error) {
                             [self blockTestCompletedWithBlock:^{
                                 STAssertEquals(SPErrorCodeInvalidRequest, error.code, @"Should be for an invalid request");
                                 STAssertEqualObjects(SponsorPayErrorMessageInvalidHashResponse, error.userInfo[SponsorPayErrorMessage], @"Should show SponsorPayErrorMessageInvalidHashResponse message");
                             }];
                         }];
        
    }];
}
- (void) testShouldBeAbleParseInvalidUIDError {
    int code;
    [SPOffersController transformResponseString:SponsorPayErrorInvalidUID intoCode:&code];
    STAssertEquals(code, SPErrorCodeInvalidUID, @"Should find invalid UID");
}
- (void) testShouldBeAbleParseInvalidAPPIDError {
    int code;
    [SPOffersController transformResponseString:SponsorPayErrorInvalidAPPID intoCode:&code];
    STAssertEquals(code, SPErrorCodeInvalidAPPID, @"Should find invalid APP ID");
}
- (void) testShouldBeAbleParseInternalServerError {
    int code;
    [SPOffersController transformResponseString:SponsorPayErrorInternalServerError intoCode:&code];
    STAssertEquals(code, SPErrorCodeInternalServerError, @"Should find internal server error");
}
- (void) testShouldNotValidateOccurencyOfError {
    int code;
    NSString *message;
    BOOL valid = [SPOffersController validateOccurencyOfMappedErrorOnResponseData:nil
                                                                             code:&code
                                                                          message:&message];
    STAssertFalse(valid, @"Should not be valid for empty data");
    
    valid = [SPOffersController validateOccurencyOfMappedErrorOnResponseData:(id)@[]
                                                                        code:&code
                                                                          message:&message];
    STAssertFalse(valid, @"Should not be valid for data <> NSDictionary");
    
    valid = [SPOffersController validateOccurencyOfMappedErrorOnResponseData:@{}
                                                                        code:&code
                                                                     message:&message];
    STAssertFalse(valid, @"Should not be valid for empty data");
    
    valid = [SPOffersController validateOccurencyOfMappedErrorOnResponseData:@{@"code": [NSNull null]}
                                                                        code:&code
                                                                     message:&message];
    STAssertFalse(valid, @"Should not be valid for null code");
}
- (void)tearDown {
    [OHHTTPStubs removeAllRequestHandlers];
}
@end
