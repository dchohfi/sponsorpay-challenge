//
//  SPOffersController.h
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPOffersParams.h"
typedef void(^SPOffersControllerSuccessBlock)(NSArray *offers);
typedef void(^SPOffersControllerFailBlock)(NSError *error);


@interface SPOffersController : NSObject

+ (void) getOffers: (SPOffersParams *) params
      successBlock: (SPOffersControllerSuccessBlock) successBlock
      andFailBlock: (SPOffersControllerFailBlock) failBlock;

//only here to test
+ (void) transformResponseString: (NSString *) responseCode intoCode: (int *) code;
+ (BOOL) validateOccurencyOfMappedErrorOnResponseData: (NSDictionary *) data
                                                 code: (int *) code
                                              message: (NSString **) message;
@end
