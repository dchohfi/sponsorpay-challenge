//
//  SPOffersController.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPOffersController.h"
#import "SPSponsorPayClient.h"
#import "SPOffer.h"
#import "AFHTTPRequestOperation.h"
#import "SPHashCalculator.h"
#import "AFJSONRequestOperation.h"
@implementation SPOffersController
+ (void) getOffers: (SPOffersParams *) params
      successBlock: (SPOffersControllerSuccessBlock) successBlock
      andFailBlock: (SPOffersControllerFailBlock) failBlock {
    [[SPSponsorPayClient client] getPath:@"feed/v1/offers.json"
                              parameters:[params data]
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     NSString *desiredHash = operation.response.allHeaderFields[@"X-Sponsorpay-Response-Signature"];
                                     if([SPHashCalculator validateResponseForBody:operation.responseString
                                                                        forApiKey:params.apiKey
                                                                   andDesiredHash:desiredHash]){
                                         NSArray *offers = @[];
                                         if(![SponsorPayNoOffersResponseCode isEqualToString:responseObject[@"code"]]){
                                             offers = [SPOffer offersWithData:responseObject[@"offers"]];
                                         }
                                         
                                         successBlock(offers);
                                         return;
                                     }
                                     failBlock([NSError errorWithDomain:SponsorPayAppDomain
                                                                   code:SPErrorCodeInvalidRequest
                                                               userInfo:@{SponsorPayErrorMessage: SponsorPayErrorMessageInvalidHashResponse}]);
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSString *message;
                                     int code;
                                     if([self containsResponseForErrorOnOperation:operation
                                                                             code:&code
                                                                          message:&message]){
                                         failBlock([NSError errorWithDomain:SponsorPayAppDomain
                                                                       code:code
                                                                   userInfo:@{SponsorPayErrorMessage: message}]);
                                         return;
                                     }
                                     failBlock(error);
                                 }];
}
+ (BOOL) containsResponseForErrorOnOperation: (AFHTTPRequestOperation *) operation
                                        code: (int *)code
                                     message: (NSString **)message {
    BOOL isJsonResponse = [operation isKindOfClass:[AFJSONRequestOperation class]];
    if(isJsonResponse){
        NSDictionary *response = ((AFJSONRequestOperation *)operation).responseJSON;
        return [self validateOccurencyOfMappedErrorOnResponseData:response
                                                             code:code
                                                          message:message];
    }
    return NO;
}
+ (BOOL) validateOccurencyOfMappedErrorOnResponseData: (NSDictionary *) data
                                                 code: (int *) code
                                              message: (NSString **) message {
    if(!data || ![data isKindOfClass:[NSDictionary class]] || [data allKeys].count == 0) return NO;
    NSString *responseCode = data[@"code"];
    BOOL haveJsonErrorCode = responseCode != nil && ![responseCode isKindOfClass:[NSNull class]];
    if(haveJsonErrorCode){
        NSArray *mappedError = @[SponsorPayErrorInvalidUID,
                                 SponsorPayErrorInvalidAPPID,
                                 SponsorPayErrorInternalServerError];
        BOOL validError = [mappedError containsObject:responseCode];
        if(validError){
            [self transformResponseString: responseCode intoCode: code];
            *message = data[@"message"];
            return YES;
        }
    }
    return NO;
}
+ (void) transformResponseString: (NSString *) responseCode intoCode: (int *) code {
    if([SponsorPayErrorInvalidUID isEqualToString:responseCode]){
        *code = SPErrorCodeInvalidUID;
    }else if ([SponsorPayErrorInvalidAPPID isEqualToString:responseCode]){
        *code = SPErrorCodeInvalidAPPID;
    }else if ([SponsorPayErrorInternalServerError isEqualToString:responseCode]){
        *code = SPErrorCodeInternalServerError;
    }
}
@end
