//
//  SPHashCalculator.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPHashCalculator.h"

@implementation SPHashCalculator

+ (NSString *) calculateHashForData: (NSDictionary *) data andApiKey: (NSString *) apiKey {
    NSArray *sortedKeys = [[data allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSMutableString *queryString = [[NSMutableString alloc] init];
    for (NSString *key in sortedKeys) {
        [queryString appendFormat:@"%@=%@", key, data[key]];
        [queryString appendString:@"&"];
    }
    [queryString appendString:apiKey];

    return [queryString sha1];
}
+ (BOOL) validateResponseForBody: (NSString *) responseBody forApiKey: (NSString *) apiKey andDesiredHash: (NSString *) hash {
    NSString *fullHash = [NSString stringWithFormat:@"%@%@", responseBody, apiKey];
    return [[fullHash sha1] isEqualToString:hash];
}
@end
