//
//  SPOffersListViewController.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPOffersListViewController.h"
#import "SPOffer.h"
#import "UIImageView+WebCache.h"
#import "SPOfferCell.h"
@interface SPOffersListViewController ()

@property (nonatomic, strong) NSArray *offers;

@end

@implementation SPOffersListViewController

- (id)initWithOffers:(NSArray *)offers
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.offers = offers;
        self.navigationItem.title = @"Offers";
    }
    return self;
}
- (void)viewDidLoad {
    [SPOfferCell registerCellOnTableView:self.tableView];
}
#pragma mark - UITableView methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.offers.count == 0 ? 44 : [SPOfferCell heightForOffer: self.offers[indexPath.row]];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.offers.count == 0 ? 1 : self.offers.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.offers.count == 0){
        return [self emptyCellForTableView: tableView];
    }
    SPOfferCell *cell = [SPOfferCell dequeueCellInTableView:tableView];
    SPOffer *offer = self.offers[indexPath.row];
    [cell setOffer:offer];
    return cell;
}
#pragma mark - private methods
- (UITableViewCell *) emptyCellForTableView: (UITableView *) tableView {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"No Content";
    return cell;
}
@end
