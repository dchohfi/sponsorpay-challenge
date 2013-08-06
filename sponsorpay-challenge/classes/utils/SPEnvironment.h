//
//  SPEnvironment.h
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPEnvironment : NSObject

+ (SPEnvironment *) environment;

@property (nonatomic, strong) NSURL *hostUrl;

@end
