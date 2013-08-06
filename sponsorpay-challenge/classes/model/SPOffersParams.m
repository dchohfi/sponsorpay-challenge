//
//  SPOffersParams.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPOffersParams.h"
#import <AdSupport/AdSupport.h>
#import "PortMapper.h"
#import "SPHashCalculator.h"
@implementation SPOffersParams


+ (SPOffersParams *) paramsWithAppId: (NSString *) appId
                                 uid: (NSString *) uid
                              apiKey: (NSString *) apiKey
                                pub0: (NSString *) pub0 {
    return [[SPOffersParams alloc] initWithAppId:appId
                                             uid:uid
                                          apiKey:apiKey
                                            pub0:pub0];
}

- (id)initWithAppId: (NSString *) appId
                uid: (NSString *) uid
             apiKey: (NSString *) apiKey
               pub0: (NSString *) pub0 {
    self = [super init];
    if (self) {
        _appId = appId;
        _uid = uid;
        _apiKey = apiKey;
        _pub0 = pub0;
        _osVersion = [[UIDevice currentDevice] systemVersion];
        _locale = [[NSLocale currentLocale] localeIdentifier];
        _deviceId = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
        _offerTypes = @"112";
    }
    return self;
}

- (NSDictionary *) data {
    NSMutableDictionary *data = [@{
                                 @"appid": self.appId,
                                 @"uid": self.uid,
                                 @"pub0": self.pub0,
                                 @"locale": self.locale,
                                 @"os_version": self.osVersion,
                                 @"timestamp": [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]],
                                 @"device_id": self.deviceId,
                                 @"offer_types": self.offerTypes,
                                 @"ip": [PortMapper findPublicAddress]
                                 } mutableCopy];
    
    [data setValue:[SPHashCalculator calculateHashForData:data andApiKey:self.apiKey]
            forKey:@"hashkey"];
    
    return data;
}
@end
