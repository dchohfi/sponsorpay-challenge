//
//  SPOfferCell.h
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPOffer;

@interface SPOfferCell : UITableViewCell

+ (CGFloat) heightForOffer: (SPOffer *) offer;
- (void) setOffer: (SPOffer *) offer;

@end
