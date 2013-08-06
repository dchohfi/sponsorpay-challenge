//
//  SPError.h
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <Foundation/Foundation.h>

//domain to validate the NSError created by us
extern NSString *const SponsorPayAppDomain;

//key to get the error inside the NSError
extern NSString *const SponsorPayErrorMessage;

//errors that can happen on the client
extern NSString *const SponsorPayErrorMessageInvalidHashResponse;

//mapping error from server
extern NSString *const SponsorPayErrorInvalidUID;
extern NSString *const SponsorPayErrorInvalidAPPID;
extern NSString *const SponsorPayErrorInternalServerError;

extern NSString *const SponsorPayNoOffersResponseCode;

typedef enum SPErrorCode {
    SPErrorCodeInvalidRequest = 0,
    SPErrorCodeInvalidUID = 1,
    SPErrorCodeInvalidAPPID = 2,
    SPErrorCodeInternalServerError = 3
} SPErrorCode;