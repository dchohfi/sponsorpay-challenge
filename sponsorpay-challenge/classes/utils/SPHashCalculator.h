//
//  SPHashCalculator.h
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPHashCalculator : NSObject

+ (NSString *) calculateHashForData: (NSDictionary *) data andApiKey: (NSString *) apiKey;
+ (BOOL) validateResponseForBody: (NSString *) responseBody forApiKey: (NSString *) apiKey andDesiredHash: (NSString *) hash;

@end
