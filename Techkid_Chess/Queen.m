//
//  Queen.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Queen.h"

@implementation Queen

- (BOOL) checkMoveWithDeltaX:(int)deltaX deltaY:(int)deltaY; {
    return (deltaX == 0 || deltaY == 0 || (deltaX == deltaY));
}

@end
