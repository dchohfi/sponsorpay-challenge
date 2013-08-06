//
//  SPOffer.h
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPThumbnail.h"

@interface SPOffer : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *offerId;
@property(nonatomic, strong) NSString *teaser;
@property(nonatomic, strong) NSString *requiredActions;
@property(nonatomic, strong) NSURL *link;
@property(nonatomic, strong) NSArray *offer_types;
@property(nonatomic, strong) SPThumbnail *thumbnail;
@property(nonatomic) int payout;

+ (SPOffer *) offerWithData: (NSDictionary *) data;
+ (NSArray *) offersWithData: (NSArray *) data;

- (NSString *) teaserWithPayout;

@end
