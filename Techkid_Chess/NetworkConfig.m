//
//  NetworkConfig.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "NetworkConfig.h"

@interface NetworkConfig ()


@end

@implementation NetworkConfig

+ (NetworkConfig*) sharedInstance {
    static NetworkConfig* instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkConfig alloc] init];
    });
    
    return instance;
}

@end
