//
//  SPOffersParserTest.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPOffersParserTest.h"
#import "SPOffer.h"

@interface SPOffersParserTest()

@property(nonatomic, strong) NSDictionary *json;

@end

@implementation SPOffersParserTest
- (void)setUp {
    [super setUp];
    NSString *jsonPath = [[NSBundle bundleForClass: [self class]] pathForResource:@"offers" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    
    self.json = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableContainers error:nil];
}

- (void) testShouldBeAbleToParseOffer {
    SPOffer *offer = [SPOffer offerWithData:self.json];
    STAssertEqualObjects(@" Tap  Fish", offer.title, @"Should be able to parse title");
    STAssertEqualObjects(@" 13554", offer.offerId, @"Should be able to parse offerId");
    STAssertEqualObjects(@"  Download and START ", offer.teaser, @"Should be able to parse teaser");
    STAssertEqualObjects(@"Download and START", offer.requiredActions, @"Should be able to parse required actions");
    STAssertEqualObjects(@"http://iframe.sponsorpay.com/mbrowser?appid=157&lpid=11387&uid=player1", [offer.link absoluteString], @"Should be able to parse link");
    STAssertEqualObjects(@"http://cdn.sponsorpay.com/assets/1808/icon175x175- 2_square_175.png", offer.thumbnail.hires, @"Should be able to parse hires thumbnail");
    STAssertEquals(90, offer.payout, @"Should be able to parse payout");
}

@end
