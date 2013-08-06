//
//  SPOffersListViewControllerTest.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPOffersListViewControllerTest.h"
#import "SPOffersListViewController.h"
@implementation SPOffersListViewControllerTest
- (void) testShouldShowEmptyContentVersionOfTableViewForNoOffers {
    SPOffersListViewController *emptyVersion = [[SPOffersListViewController alloc] initWithOffers:@[]];
    STAssertEquals(1, [emptyVersion tableView:emptyVersion.tableView
                        numberOfRowsInSection:0], @"Should have one rown even if the offers is empty");
    STAssertEqualObjects(@"No Content", [emptyVersion tableView:emptyVersion.tableView
                                          cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]].textLabel.text, @"Should show only one cell with 'No Content' text");
    STAssertEquals(44.f, [emptyVersion tableView:emptyVersion.tableView
                       heightForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]], @"Should have an empty row with 44 height");
    
}
@end
