//
//  SPOffer.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPOffer.h"
#import "DCKeyValueObjectMapping.h"
#import "DCParserConfiguration.h"
#import "DCArrayMapping.h"
#import "SPOfferType.h"
@implementation SPOffer

+ (SPOffer *) offerWithData: (NSDictionary *) data {
    return [[self parser] parseDictionary:data];
}
+ (NSArray *) offersWithData: (NSArray *) data {
    return [[self parser] parseArray:data];
}
+ (DCKeyValueObjectMapping *) parser {
    static DCKeyValueObjectMapping *parser = nil;
    if(parser == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            DCParserConfiguration *parserConfiguration = [DCParserConfiguration configuration];
            DCArrayMapping *offersTypeMapping = [DCArrayMapping mapperForClassElements:[SPOfferType class]
                                                                          forAttribute:@"offer_types"
                                                                               onClass:[SPOffer class]];
            [parserConfiguration addArrayMapper:offersTypeMapping];
            parser = [DCKeyValueObjectMapping mapperForClass:[SPOffer class]
                                            andConfiguration:parserConfiguration];
        });
    }
    return parser;
}
- (NSString *) teaserWithPayout {
    return [NSString stringWithFormat:@"%@\nPayout: %i", self.teaser, self.payout];
}
@end
