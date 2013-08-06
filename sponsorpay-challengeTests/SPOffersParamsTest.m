//
//  SPOffersParamsTest.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//
#import "SPOffersParamsTest.h"
#import "SPOffersParams.h"
#import "OCMock.h"

#import <Foundation/Foundation.h>

@implementation SPOffersParamsTest

- (void) testInitializationOfOffersParams {
    NSString *appId = @"App Id";
    NSString *uid = @"UID";
    NSString *apiKey = @"Api KEY";
    NSString *pub0 = @"Pub 0";
    
    id deviceMock = [OCMockObject partialMockForObject:[UIDevice currentDevice]];
    
    [(UIDevice *)[deviceMock expect] systemVersion];
    
    SPOffersParams *params = [SPOffersParams paramsWithAppId:appId
                                                         uid:uid
                                                      apiKey:apiKey
                                                        pub0:pub0];
    STAssertEqualObjects(appId, params.appId, @"Should be same app id");
    STAssertEqualObjects(uid, params.uid, @"Should be same uid");
    STAssertEqualObjects(apiKey, params.apiKey, @"Should be same api key");
    STAssertEqualObjects(pub0, params.pub0, @"Should be same pub0");
    
    [deviceMock verify];
    [deviceMock stopMocking];
}

@end
