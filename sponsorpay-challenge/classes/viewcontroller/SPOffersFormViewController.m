//
//  SPOffersFormViewController.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPOffersFormViewController.h"
#import "SPOffersController.h"
#import "SPOffer.h"
#import "SVProgressHUD.h"
#import "SPOffersListViewController.h"
@interface SPOffersFormViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textUID;
@property (weak, nonatomic) IBOutlet UITextField *textApiKey;
@property (weak, nonatomic) IBOutlet UITextField *textAppId;
@property (weak, nonatomic) IBOutlet UITextField *textPub0;

@end

@implementation SPOffersFormViewController

- (id)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Find Offers";
    }
    return self;
}
#pragma mark - IBAction
- (IBAction)searchForOffers{
    [SVProgressHUD showWithStatus:@"Looking for offers"];
    SPOffersParams *params = [SPOffersParams paramsWithAppId:self.textAppId.text
                                                         uid:self.textUID.text
                                                      apiKey:self.textApiKey.text
                                                        pub0:self.textPub0.text];
    
    [SPOffersController getOffers:params
                     successBlock:^(NSArray *offers) {
                         [SVProgressHUD dismiss];
                         [self showListForOffers: offers];
                     }
                     andFailBlock:^(NSError *error) {
                         NSString *message = @"Bad Stuff :(";
                         if([error.domain isEqualToString:SponsorPayAppDomain]){
                             message = error.userInfo[SponsorPayErrorMessage];
                         }
                         [SVProgressHUD showErrorWithStatus:message];
                     }];
}
#pragma mark - private methods
- (void) showListForOffers: (NSArray *) offers {
    SPOffersListViewController *offersList = [[SPOffersListViewController alloc] initWithOffers:offers];
    [self.navigationController pushViewController:offersList animated:YES];
}
@end
