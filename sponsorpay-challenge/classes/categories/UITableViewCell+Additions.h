//
//  UITableViewCell+Additions.h
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Additions)
+ (void) registerCellOnTableView: (UITableView *) tableView;
+ (instancetype) dequeueCellInTableView: (UITableView *) tableView;
@end
