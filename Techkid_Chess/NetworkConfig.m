//
//  NetworkConfig.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "NetworkConfig.h"

#define NET_CONFIG_DEFAULT_ROOM @"tbl_room_69"
#define NET_CONFIG_DEFAULT_SERVER_URL @"http://45.32.247.228:3015"

@interface NetworkConfig ()


@end

@implementation NetworkConfig

- (instancetype) init {
    self = [super init];
    if(self) {
        self.roomName = NET_CONFIG_DEFAULT_ROOM;
        self.url = [NSURL URLWithString:NET_CONFIG_DEFAULT_SERVER_URL];
    }
    return self;
}

+ (NetworkConfig*) sharedInstance {
    static NetworkConfig* instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkConfig alloc] init];
    });
    
    return instance;
}

@end
