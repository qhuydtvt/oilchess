//
//  Knight.m
//  Techkid_Chess
//
//  Created by admin on 6/4/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Knight.h"

@implementation Knight

- (BOOL) checkMoveWithDeltaX:(int)deltaX deltaY:(int)deltaY; {
    return ((deltaX == 1 && deltaY == 2) || (deltaX == 2 && deltaY == 1));
}

@end
