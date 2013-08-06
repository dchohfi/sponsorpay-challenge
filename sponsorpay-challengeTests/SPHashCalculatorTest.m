//
//  SPHashCalculatorTest.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPHashCalculatorTest.h"
#import "SPHashCalculator.h"
#import "OCMock.h"
@implementation SPHashCalculatorTest
- (void) testCalculateSHA1FromParams {
    NSDictionary *data = @{@"appid": @"157",
                           @"uid" : @"player1",
                           @"ip" : @"212.45.111.17",
                           @"locale" : @"de",
                           @"device_id" : @"2b6f0cc904d137be2e1730235f5664094b831186",
                           @"ps_time" : @"1312211903",
                           @"pub0" : @"campaign2",
                           @"page" : @"2",
                           @"timestamp" : @"1312553361"};
    NSString *hash = [SPHashCalculator calculateHashForData:data
                                                  andApiKey:@"e95a21621a1865bcbae3bee89c4d4f84"];
    
    STAssertEqualObjects(@"7a2b1604c03d46eec1ecd4a686787b75dd693c4d", hash, @"Should be able to generate sha1 from values");
}
@end
