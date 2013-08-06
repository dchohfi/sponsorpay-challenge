//
//  SPAppDelegate.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPAppDelegate.h"
#import "SPOffersFormViewController.h"
@implementation SPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SPOffersFormViewController *offersForm = [[SPOffersFormViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:offersForm];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
