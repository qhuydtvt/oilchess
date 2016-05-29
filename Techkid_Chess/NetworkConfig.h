//
//  NetworkConfig.h
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkConfig : NSObject

@property NSString* userName;

+ (NetworkConfig*) sharedInstance;

@end
