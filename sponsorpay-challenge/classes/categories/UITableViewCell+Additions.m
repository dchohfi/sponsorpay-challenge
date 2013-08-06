//
//  UITableViewCell+Additions.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "UITableViewCell+Additions.h"

@implementation UITableViewCell (Additions)
+ (void) registerCellOnTableView: (UITableView *) tableView {
    [tableView registerClass:[self class]
      forCellReuseIdentifier:NSStringFromClass([self class])];
}
+ (instancetype) dequeueCellInTableView: (UITableView *) tableView {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
}
@end
