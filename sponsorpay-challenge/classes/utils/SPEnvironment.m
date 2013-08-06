//
//  SPEnvironment.m
//  sponsorpay-challenge
//
//  Created by Diego Chohfi on 8/6/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "SPEnvironment.h"

@implementation SPEnvironment
+ (SPEnvironment *) environment {
    static SPEnvironment *environment = nil;
    if(environment == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            environment = [[SPEnvironment alloc] init];
        });
    }
    return environment;
}
- (id)init {
    self = [super init];
    if (self) {
        NSDictionary *environment = [self loadEnvironmentFromBundle];
        self.hostUrl = [NSURL URLWithString:environment[@"API_HOST_URL"]];
    }
    return self;
}
- (NSDictionary *) loadEnvironmentFromBundle {
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *environmentFilePath = [bundlePath stringByAppendingPathComponent:@"environment.plist"];
    return [NSDictionary dictionaryWithContentsOfFile:environmentFilePath];
}
@end
