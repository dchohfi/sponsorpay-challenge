//
//  SPOffersParams.h
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPOffersParams : NSObject

@property(nonatomic, readonly) NSString *appId;
@property(nonatomic, readonly) NSString *uid;
@property(nonatomic, readonly) NSString *apiKey;
@property(nonatomic, readonly) NSString *pub0;

@property(nonatomic, readonly) NSString *osVersion;
@property(nonatomic, readonly) NSString *locale;
@property(nonatomic, readonly) NSString *timestamp;
@property(nonatomic, readonly) NSString *deviceId;

@property(nonatomic, readonly) NSString *ip;
@property(nonatomic, readonly) NSString *offerTypes;

+ (SPOffersParams *) paramsWithAppId: (NSString *) appId
                                 uid: (NSString *) uid
                              apiKey: (NSString *) apiKey
                                pub0: (NSString *) pub0;
- (NSDictionary *) data;
@end
