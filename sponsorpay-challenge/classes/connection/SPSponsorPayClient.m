//
//  SPSponsorPayClient.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPSponsorPayClient.h"
#import "AFJSONRequestOperation.h"
#import "SPEnvironment.h"
@implementation SPSponsorPayClient
+(SPSponsorPayClient *)client {
    static SPSponsorPayClient *singletonInstance = nil;
    
    if(singletonInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSURL *url = [SPEnvironment environment].hostUrl;
            singletonInstance = [[SPSponsorPayClient alloc] initWithBaseURL:url];
            [singletonInstance setParameterEncoding:AFJSONParameterEncoding];
            [singletonInstance registerHTTPOperationClass:[AFJSONRequestOperation class]];
        });
    }
    return singletonInstance;
}
@end
